//
//  BioMetricAuthencation.swift
//  MybkMobile
//
//  Created by DucTran on 26/03/2023.
//

import Foundation
import LocalAuthentication

enum BioMetricType {
    case none
    case touch
    case face
}

enum BiometryState {
    case available, locked, notAvailable
}

enum BioMetricAuthenError: Error, LocalizedError, Identifiable {
    var id: String {
        return self.localizedDescription
    }
    
    case invalidCredential
    case denidedAccess
    case noFaceId
    case noTouchId
    case biometricError
    case credentialNotSave
    
    var errorDescription: String {
        switch self {
        case .invalidCredential:
            return "Username and password incorrect"
        case .denidedAccess:
            return "Bio Metric reject access"
        case .noFaceId:
            return "Not register any face id yet"
        case .noTouchId:
            return "Not register any touch id yet"
        case .biometricError:
            return "Cannot recognize Bio Metric info"
        case .credentialNotSave:
            return "Not save any information yet"
        }
    }
    
}

fileprivate struct Credential: Codable {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

final class BioMetric {
    public static let shared = BioMetric()
    
    var bioMetricType: BioMetricType {
        var context = LAContext()
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touch
        case .faceID:
            return .face
        @unknown default:
            return .none
        }
    }
    
    var biometryState: BiometryState {
        let authContext = LAContext()
        var error: NSError?
        
        let biometryAvailable = authContext.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let laError = error as? LAError, laError.code == LAError.Code.biometryLockout {
            return .locked
        }
        return biometryAvailable ? .available : .notAvailable
    }
    
    func createBioProtectedEntry(key: String, username: String, password: String) -> Bool {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(Credential(username: username, password: password)) {
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : key,
                kSecAttrAccessControl as String: getBioSecAccessControl(),
                kSecValueData as String   : data ] as CFDictionary
            
            if SecItemAdd(query as CFDictionary, nil) == errSecSuccess {
                return true
            }
        }
        return false
    }
    
    func getEntryFromBioProtected(key: String, completion: @escaping ((username: String, password: String)?) -> Void) {
        checkBiometryState { success in
            guard success else {
                // Biometric authentication is not available
                return
            }
            DispatchQueue.global().async {
                let decoder = JSONDecoder()
                if let data = self.loadBioProtected(key: key) ,
                   let decoded = try? decoder.decode(Credential.self, from: data) {
                    completion((username: decoded.username, password: decoded.password))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func clearEntryFromBioProtected(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue as Any ,
            kSecAttrAccessControl as String: getBioSecAccessControl(),
            kSecMatchLimit as String  : kSecMatchLimitOne ] as CFDictionary
        
        if SecItemDelete(query) == errSecSuccess {
            return true
        }
        return false
    }
    
}


extension BioMetric {
    
    private func loadBioProtected(key: String) -> Data? {
        var query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue as Any ,
            kSecAttrAccessControl as String: getBioSecAccessControl(),
            kSecMatchLimit as String  : kSecMatchLimitOne ]
        var dataTypeRef: AnyObject? = nil
        
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return (dataTypeRef! as! Data)
        } else {
            return nil
        }
    }
    
    private func getBioSecAccessControl() -> SecAccessControl {
        var access: SecAccessControl?
        var error: Unmanaged<CFError>?
        
        access = SecAccessControlCreateWithFlags(nil,
                                                 kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                 .biometryCurrentSet,
                                                 &error)
        
        precondition(access != nil, "SecAccessControlCreateWithFlags failed")
        return access!
    }
    
    private func checkBiometryState(_ completion: @escaping (Bool)->Void) {
        let bioState = self.biometryState
        guard bioState != .notAvailable else {
            // Can't read entry, biometry not available
            completion(false)
            return
        }
        if bioState == .locked {
            // To unlock biometric authentication iOS requires user to enter a valid passcode
            let authContext = LAContext()
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
                                       localizedReason: "Access sample keychain entry",
                                       reply: { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        // Can't read entry, check error for details
                        completion(false)
                    }
                }
            })
        } else {
            completion(true)
        }
    }
}

//
//  Storage.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import UIKit

class EncriptStorageKey {
    static let username = "key.username"
    static let password = "key.password"
    static let name  = "key.name"
    static let faculty  = "key.faculty"
    static let isSaveData  = "key.saveData"
    static let encryptionKey = "mySecretEncryptionKey"
    static let mybkToken = "key.mybkToken"
    
    static func updateStorage(with key: String, value: String) -> Bool{
        let encryptedData = value.aesDecrypt(key: UUID().uuidString, iv: UIDevice.current.identifierForVendor!.uuidString)
        UserDefaults.standard.setValue(encryptedData, forKey: key)
        return true
    }
    
    static func clearStorage(with key: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return true
    }
    
    static func getStorage (with key: String) -> String? {
        guard let data = UserDefaults.standard.string(forKey: key) else { return nil }
        let decryptedData = data.aesDecrypt(key: UUID().uuidString, iv: UIDevice.current.identifierForVendor!.uuidString)
        return decryptedData
    }
}

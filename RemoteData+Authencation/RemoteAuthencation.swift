//
//  RemoteAuthencation.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation
import SwiftSoup
import CryptoSwift

final class SSOServiceManager {
    
    static public let shared: SSOServiceManager = .init()
    
    var username: String?
    var password: String?
    var faculty: String?
    var studentName: String?
    var serviceEncryptIV: String?
    var mybkToken: String?
    var JSSESSIONID: String?
    
    func login(username: String? = nil,
               password: String? = nil,
               ssoCompletion: @escaping (SSOState) -> Void,
               myBKCompletion: @escaping (MybkState) -> Void) {
        if let username = username, let password = password {
            SSOLogin(username: username, password: password) { state in
                if state == .LOGGED_IN {
                    self.getMyBKToken {
                        self.saveTemporaryCredential()
                        myBKCompletion($0)
                    }
                } else {
                    ssoCompletion(state)
                }
            }
        } else {
            BioMetric.shared.getEntryFromBioProtected(key: Constant.Key.bioMetric) {
                guard let result = $0 else {
                    ssoCompletion(.NO_CREDENTIALS)
                    return
                }
                self.SSOLogin(username: result.username, password: result.password){ state in
                    if state == .LOGGED_IN {
                        self.getMyBKToken {
                            self.saveTemporaryCredential()
                            myBKCompletion($0)
                        }
                    } else {
                        ssoCompletion(state)
                    }
                }
            }
        }
    }
    
    func logout(completion: @escaping(Bool) -> Void) {
        if let JSSESSIONID = self.JSSESSIONID {
            getRequest(with: Constant.Network.SSO_MYBK_LOGOUT_URL,
                       header: ["Cookie": JSSESSIONID]) { result in
                if case .success(( _,let response)) = result,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    completion(true)
                    return
                }
            }
        }
        completion(false)
    }
    
    func saveToBioMetric(completion: @escaping (Bool) -> Void) {
        if let result = self.decryptCredential() {
            let res = BioMetric.shared.createBioProtectedEntry(key: Constant.Key.bioMetric,
                                                               username: result.username,
                                                               password: result.password,
                                                               faculty: result.faculty,
                                                               studentName: result.studentName)
            completion(res)
        }
        completion(false)
    }
    
    func getCurrentCredential() -> (username: String,faculty: String,studentName: String)? {
        if let result = self.decryptCredential() {
            return(result.username, result.faculty, result.studentName)
        }
        return nil
    }
    
    func clearBioMetric() {
        if BioMetric.shared.clearEntryFromBioProtected(key: Constant.Key.bioMetric) {
            print("cleared saved info")
        } else {
            print("cannot clear saved info")
        }
    }
    
    func clearMemory() {
        self.username = nil
        self.password = nil
        self.serviceEncryptIV = nil
        self.mybkToken = nil
        self.JSSESSIONID = nil
    }
}

// MARK: - SSO and mybk login
extension SSOServiceManager {
    private func SSOLogin(username: String,
                       password: String,
                       completion: @escaping (SSOState) -> Void) {
        self.getSSOSession() {
            let (state, lt, execution) = $0
            if case .UNAUTHORIZED = state {
                self.postSSOForm(username: username,
                                 password: password,
                                 lt: lt,
                                 execution: execution) {
                    if case .LOGGED_IN = $0 {
                        self.username = username
                        self.password = password
                    }
                    completion($0)
                }
            } else {
                if case .LOGGED_IN = state {
                    self.username = username
                    self.password = password
                }
                completion(state)
            }
        }
    }
    
    private func getMyBKToken(completion: @escaping (MybkState) -> Void) {
        // android need this to check , but not for ios
        /*
         if response.statusCode == 302 {
            let location = response.allHeaderFields["Location"] as? String
            var comps = URLComponents(string: location ?? "")
            comps?.scheme = "https"
            getRequest(url: comps?.string ?? "") {
                if $2 != nil {
                    self.getStinfoToken {
                        completion($0, $1)
                    }
                }
            }
         }
         */
        getRequest(with: Constant.Network.SSO_MYBK_REDIRECT_URL) { [unowned self] result in
            switch result {
            case .success((let data, let response)):
                guard let htmlString = String(data: data, encoding: .ascii),
                      let token = HTMLutils.getHeaderMetaContent(of: htmlString, attribute: ["name": "_token"]),
                      let httpResponse = response as? HTTPURLResponse,
                      let (faculty, studentName) = self.getProfileInfo(responseBody: htmlString),
                      httpResponse.statusCode == 200 else {
                    completion(.UNKNOWN)
                    return
                }
                if let cookie = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                    self.JSSESSIONID = cookie
                }
                self.mybkToken = token
                self.faculty = faculty
                self.studentName = studentName
                completion(.LOGGED_IN)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Network authorize Ultility
extension SSOServiceManager {
    private func getProfileInfo(responseBody: String) -> (fullName: String, faculty: String)? {
        if let fullName = HTMLutils.getContentWithFullXpath(of: responseBody, xpath: "div[class$='top-avatar2'] div"),
           let faculty = HTMLutils.getContentWithFullXpath(of: responseBody, xpath: "div[class$='top-avatar2'] p") {
            return (fullName, faculty)
        } else {
            print("cannot get profile")
            return nil
        }
    }
    
    private func postSSOForm(username: String,
                             password: String,
                             lt: String,
                             execution: String,
                             completion: @escaping (SSOState) -> Void) {
        let requestHeader = ["Content-Type": "application/x-www-form-urlencoded"]
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_eventId", value: "submit"),
                                           URLQueryItem(name: "execution", value: execution),
                                           URLQueryItem(name: "lt", value: lt),
                                           URLQueryItem(name: "username", value: username),
                                           URLQueryItem(name: "password", value: password)]
        postRequest(url: Constant.Network.SSO_URL,
                    header: requestHeader,
                    body: requestBodyComponent) { result in
            switch result {
            case .success((let data,let response)):
                let result = self.analizeSSOSession(data: data, response: response)
                completion(result.status)
            case .failure:
                completion(.UNKNOWN)
            }
        }
    }
    
    private func getSSOSession(completion: @escaping ((SSOState, String, String)) -> Void) {
        getRequest(with: Constant.Network.SSO_URL) { result in
            switch result {
            case .success((let data, let response)):
                let result = self.analizeSSOSession(data: data, response: response)
                completion(result)
            case .failure(_):
                completion((.NETWORKERROR,"",""))
            }
        }
    }
    
    private func analizeSSOSession(data: Data, response: URLResponse) -> (status: SSOState, lt: String, execution: String){
        guard let htmlString = String(data: data, encoding: .ascii),
              let httpResponse = response as? HTTPURLResponse else {
            return (.UNKNOWN,"","")
        }
        let lt = HTMLutils.getValueOf(of: htmlString, element: "input", attribute: ["name": "lt"]) ?? ""
        let execution = HTMLutils.getValueOf(of: htmlString, element: "input", attribute: ["name": "execution"]) ?? ""
        if httpResponse.statusCode == 403 {
            return (.TOO_MANY_TRIES,lt,execution)
        } else if  htmlString.contains(Constant.Network.HTML_WRONG_CREDENTIAL) {
            return (.WRONG_PASSWORD,lt,execution)
        } else if htmlString.contains(Constant.Network.HTML_LOGIN_SUCCESS) {
            return (.LOGGED_IN,lt,execution)
        } else if lt != "" || execution != "" {
            return (.UNAUTHORIZED,lt,execution)
        } else {
            return (.UNKNOWN,lt,execution)
        }
    }
    
    private func saveTemporaryCredential() {
        // get generate temporary key
        guard let username = self.username,
              let password = self.password,
              let faculty = self.faculty,
              let studentName = self.studentName else { return }
        print("credential loaded -------- ")
        self.serviceEncryptIV = String.randomString(length: 16)
        do {
            let keyString = String(decoding: UUID().uuidString.toFixedUInt8Array(), as: UTF8.self)
            let ivString = String(decoding: serviceEncryptIV!.toFixedUInt8Array(), as: UTF8.self)
            let aes = try AES(key: keyString,
                              iv: ivString )
            let encryptedUsername = try aes.encrypt(username.bytes)
            let encryptedPassword = try aes.encrypt(password.bytes)
            let encryptedFaculty = try aes.encrypt(faculty.bytes)
            let encryptedStudentName = try aes.encrypt(studentName.bytes)
            self.username = String(decoding: encryptedUsername, as: UTF8.self)
            self.password = String(decoding: encryptedPassword, as: UTF8.self)
            self.faculty = String(decoding: encryptedFaculty, as: UTF8.self)
            self.studentName = String(decoding: encryptedStudentName, as: UTF8.self)
        } catch {
            print("cannot encrypt credential")
        }
    }
    
    private func decryptCredential() -> (username: String, password: String, faculty: String, studentName: String)? {
        guard let username = username,
              let password = password,
              let faculty = faculty,
              let studentName = studentName,
              let temporaryIV = serviceEncryptIV else {
            return nil
        }
        // decrypt to save
        do {
            let keyString = String(decoding: UUID().uuidString.toFixedUInt8Array(), as: UTF8.self)
            let ivString = String(decoding: temporaryIV.toFixedUInt8Array(), as: UTF8.self)
            let aes = try AES(key: keyString,
                              iv: ivString )
            let usernameDecrypted = try aes.decrypt(username.bytes)
            let passwordDecrypted = try aes.decrypt(password.bytes)
            let facultyDecrypted = try aes.decrypt(faculty.bytes)
            let studentNameDecrypted = try aes.decrypt(studentName.bytes)
            let convertedUsername = String(decoding: usernameDecrypted, as: UTF8.self)
            let convertedPassword = String(decoding: passwordDecrypted, as: UTF8.self)
            let convertedFaculty = String(decoding: facultyDecrypted, as: UTF8.self)
            let convertedStudentName = String(decoding: studentNameDecrypted, as: UTF8.self)
            return (convertedUsername, convertedPassword, convertedFaculty, convertedStudentName)
        } catch {
            return nil
        }
    }
    
}

//
//  SSO.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation
import SwiftSoup

final class SSOServiceManager {
    
    static public let shared: SSOServiceManager = .init()
    
    func login(username: String? = nil,
               password: String? = nil,
               completion: @escaping (SSOState) -> Void) {
        if let username = username, let password = password {
            SSOLogin(username: username, password: password) { [weak self] state in
                if case .LOGGED_IN = state {
                    self?.updateCredential(username, password)
                }
                completion(state)
            }
        } else {
            if let isSave = EncriptStorageKey.getStorage(with: EncriptStorageKey.isSaveData),
               NSString(string: isSave).boolValue {
                if let username = EncriptStorageKey.getStorage(with: EncriptStorageKey.username),
                   let password = EncriptStorageKey.getStorage(with: EncriptStorageKey.password) {
                    SSOLogin(username: username, password: password) { state in
                        completion(state)
                    }
                }
            } else {
                completion(.NO_CREDENTIALS)
            }
        }
    }
    
    func getMyBKToken(completion: @escaping (String?,MybkState) -> Void) {
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
        getRequest(with: Constant.SSO_MYBK_REDIRECT_URL) { result in
            switch result {
            case .success((let data, let response)):
                guard let htmlString = String(data: data, encoding: .ascii),
                      let token = HTMLutils.getHeaderMetaContent(of: htmlString, attribute: ["name": "_token"]),
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    completion(nil, .UNKNOWN)
                    return
                }
                completion(token,.LOGGED_IN)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func SSOLogin(username: String,
                       password: String,
                       completion: @escaping (SSOState) -> Void) {
        self.getSSOSession() {
            let (state, lt, execution) = $0
            if case .UNAUTHORIZED = state {
                self.postSSOForm(username: username,
                                 password: password,
                                 lt: lt,
                                 execution: execution) {
                    completion($0)
                }
            } else {
                completion(state)
            }
        }
    }

    func updateCredential(_ username: String, _ password: String) {
        let encrt =
        EncriptStorageKey.updateStorage(with: EncriptStorageKey.username, value: username) &&
        EncriptStorageKey.updateStorage(with: EncriptStorageKey.password, value: password)
        if encrt {
            print("success save user and password")
        } else {
            print("save fail")
        }
    }
    
    func clearCredential() {
        let clear = EncriptStorageKey.clearStorage(with: EncriptStorageKey.name) &&
                    EncriptStorageKey.clearStorage(with: EncriptStorageKey.faculty) &&
                    EncriptStorageKey.clearStorage(with: EncriptStorageKey.username) &&
                    EncriptStorageKey.clearStorage(with: EncriptStorageKey.password)
        if clear {
            print("success clear all save data")
        } else {
            print("save fail")
        }
    }
    
    func updateProfileStore(_ fullName: String, _ faculty: String) {
        let encrt = EncriptStorageKey.updateStorage(with: EncriptStorageKey.name, value: fullName) &&
                    EncriptStorageKey.updateStorage(with: EncriptStorageKey.faculty, value: faculty)
        if encrt {
            print("success save fullname and faculty")
        } else {
            print("save fail")
        }
    }
}
extension SSOServiceManager {
    
    private func getProfileInfo(responseBody: String) {
        if let fullName = HTMLutils.getContentWithFullXpath(of: responseBody, xpath: "div[class=top-avatar2]/div"),
           let faculty = HTMLutils.getContentWithFullXpath(of: responseBody, xpath: "div[class=top-avatar2]/p") {
            updateProfileStore(fullName, faculty)
        } else {
            print("cannot get profile")
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
        postRequest(url: Constant.SSO_URL,
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
        getRequest(with: Constant.SSO_URL) { result in
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
        } else if  htmlString.contains(Constant.HTML_WRONG_CREDENTIAL) {
            return (.WRONG_PASSWORD,lt,execution)
        } else if htmlString.contains(Constant.HTML_LOGIN_SUCCESS) {
            return (.LOGGED_IN,lt,execution)
        } else if lt != "" || execution != "" {
            return (.UNAUTHORIZED,lt,execution)
        } else {
            return (.UNKNOWN,lt,execution)
        }
    }
}

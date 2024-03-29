//
//  RemoteAuthencation.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation
import SwiftSoup

final class SSOServiceManager {
    
    static public let shared: SSOServiceManager = .init()
    
    private var username: String?
    private var password: String?
    private var serviceEncryptIV: String?
    private var mybkToken: String?
    private var JSSESSIONID: String?
    
    func login(username: String? = nil,
               password: String? = nil,
               ssoCompletion: @escaping (SSOState) -> Void,
               myBKCompletion: @escaping (MybkState) -> Void) {
        if let username = username, let password = password, !username.isEmpty, !password.isEmpty {
            SSOLogin(username: username, password: password) { state in
                if state == .LOGGED_IN {
                    self.username = username
                    self.password = password
                    self.getMyBKToken {
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
                myBKCompletion(.BIOMETRIC(username: result.username, password: result.password))
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
    
    func getMyBKToken() -> String? {
        return mybkToken
    }
    
    func saveToBioMetric(completion: @escaping (Bool) -> Void) {
        if let username = username, let password = password {
            let res = BioMetric.shared.createBioProtectedEntry(key: Constant.Key.bioMetric,
                                                               username: username,
                                                               password: password)
            completion(res)
        }
        completion(false)
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
            if .UNAUTHORIZED == state {
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
                      httpResponse.statusCode == 200 else {
                    completion(.UNKNOWN)
                    return
                }
                if let cookie = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                    self.JSSESSIONID = cookie
                }
                self.mybkToken = token
                completion(.LOGGED_IN)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Network authorize Ultility
extension SSOServiceManager {
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
}

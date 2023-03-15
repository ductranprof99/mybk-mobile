//
//  SSO.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation
import SwiftSoup

class SSOServiceManager {
    func login() {
        // check login status first
        // if save -> is need to update credential
        // if need update then new
    }
    
    func checkLoginStatus() {
        // check local storage
        // if not have local, return no login
        // if have local, go to update credential
        
    }
    
    func getMyBKToken() {
        
    }
    
    func getSSOSession(username: String,
                       password: String,
                       completion: @escaping (SSOState) -> Void) {
        self.getSSOSession() {
            let (state, lt, execution) = $0
            if case .UNAUTHORIZED = state {
                self.postSSOForm(username: username,
                                 password: password,
                                 lt: lt,
                                 execution: execution) {
                    // TODO
                }
            } else {
                completion(state)
            }
        }
    }
    
    
    
    func getProfileInfo(responseBody: String) {
        do {
            var doc: Document = try SwiftSoup.parse(responseBody)
            var profileBlock = try doc.select("div[class=top-avatar2]").first()?.children()
            var fullName = try profileBlock?.select("div").first()?.text() ?? ""
            var faculty = try profileBlock?.select("p").first()?.text() ?? ""
            updateProfileStore(fullName, faculty)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateCredential() {
        
    }
    
    func clear() {
        
    }
    
    func updateProfileStore(_ fullName: String, _ faculty: String) {
        // TODO
    }
}
extension SSOServiceManager {
    
    private func postSSOForm(username: String,
                             password: String,
                             lt: String,
                             execution: String,
                             completion: @escaping () -> Void) {
        let requestHeader = ["Content-Type": "application/x-www-form-urlencoded"]
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_eventId", value: "submit"),
                                           URLQueryItem(name: "execution", value: execution),
                                           URLQueryItem(name: "lt", value: lt),
                                           URLQueryItem(name: "username", value: username),
                                           URLQueryItem(name: "password", value: password)]
        var request = URLRequest(url: URL(string: Constant.SSO_URL)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeader
        request.httpBody = requestBodyComponent.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // TODO
        }.resume()
    }
    
    private func getSSOSession(completion: @escaping ((SSOState, String, String)) -> Void) {
        guard let url = URL(string: Constant.SSO_URL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
            if error != nil {
                completion((.NETWORKERROR,"",""))
            } else {
                guard let data = data,
                      let htmlString = String(data: data, encoding: .ascii),
                      let (lt, execution) = self.detachSSOHTMLElement(input: htmlString) else {
                    completion((.UNKNOWN,"",""))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 403 {
                        completion((.TOO_MANY_TRIES,lt,execution))
                    } else if  htmlString.contains(Constant.HTML_WRONG_CREDENTIAL) {
                        completion((.WRONG_PASSWORD,lt,execution))
                    } else if htmlString.contains(Constant.HTML_LOGIN_SUCCESS) {
                        completion((.LOGGED_IN,lt,execution))
                    } else if lt != "" || execution != "" {
                        completion((.UNAUTHORIZED,lt,execution))
                    } else {
                        completion((.UNKNOWN,lt,execution))
                    }
                }
            }
        }
        task.resume()
    }
    
    private func detachSSOHTMLElement(input str: String) -> (lt:String,execution:String)? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            let executeEle: Element = try doc.select("input[name$=\"execution\"]").first()!
            let executeVal = try executeEle.val()
            let ltEle: Element = try doc.select("input[name$=\"lt\"]").first()!
            let ltVal = try ltEle.val()
            return (lt:ltVal,execution: executeVal)
        } catch {
            print("parsing html error")
        }
        return nil
    }
}

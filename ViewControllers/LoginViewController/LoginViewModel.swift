//
//  LoginViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation


final class LoginViewModel {
    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        SSOServiceManager.shared.login(username: username, password: password) { state in
            if case .LOGGED_IN = state {
                self.mybkToken {
                    completion($0)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func mybkToken(completion: @escaping (Bool) -> Void) {
        SSOServiceManager.shared.getMyBKToken { (str, state) in
            switch state {
            case .LOGGED_IN:
                if let token = str {
                    if EncriptStorageKey.updateStorage(with: Constant.EncryptKey.mybkToken, value: token) {
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            default:
                completion(false)
            }
        }
    }
}

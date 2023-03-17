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
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

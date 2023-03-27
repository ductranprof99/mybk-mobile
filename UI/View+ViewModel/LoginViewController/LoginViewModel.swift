//
//  LoginViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import UIKit

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
            if case .LOGGED_IN = state, str != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getBioMetricUIImage() -> UIImage? {
        let type = BioMetric.shared.bioMetricType
        switch type {
        case .none:
            return nil
        case .touch:
            return UIImage(named: "icon_touch")
        case .face:
            return UIImage(named: "icon_face")
        }
    }
    
    func biometricLogin(completion: @escaping (Bool) -> Void) {
        SSOServiceManager.shared.login { state in
            if case .LOGGED_IN = state {
                self.mybkToken {
                    completion($0)
                }
            } else {
                completion(false)
            }
        }
    }
}

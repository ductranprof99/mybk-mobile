//
//  LoginViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import UIKit


final class LoginViewModel {
    
    func login(username: String?, password: String?, completion: @escaping (LoginStatus) -> Void) {
        SSOServiceManager
            .shared
            .login(username: username,
                   password: password,
                   ssoCompletion: { completion($0.asLoginStatus()) },
                   myBKCompletion: { completion($0.asLoginStatus()) })
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
    
    func biometricLogin(completion: @escaping (LoginStatus) -> Void) {
        SSOServiceManager
            .shared
            .login (ssoCompletion: { completion($0.asLoginStatus()) },
                    myBKCompletion: { completion($0.asLoginStatus()) })
    }
}

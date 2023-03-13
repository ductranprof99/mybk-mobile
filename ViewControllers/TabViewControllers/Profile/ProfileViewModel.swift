//
//  ProfileViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 13/03/2023.
//

import Foundation
import UIKit

final class ProfileViewModel {
    typealias UserInfo = (userName: String, userMail: String, userMajor: String)
    func getUserInfomation() -> UserInfo {
        return ("Loolol", "Loolol@hcmut.edu.vn", "Khoa boc vac")
    }
    
    func getGithubLink() -> String{
        return "www.google.com"
    }
    
    func getToggleState() -> Bool {
        return true
    }
    
    func getVersion() -> String {
        return "Phiên bản: 1.0.0-rc"
    }
    
    func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func logout(completion: @escaping () -> Void) {
        completion()
    }
    
}

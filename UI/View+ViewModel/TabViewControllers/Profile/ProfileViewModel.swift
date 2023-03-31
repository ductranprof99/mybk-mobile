//
//  ProfileViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 13/03/2023.
//

import Foundation
import UIKit

final class ProfileViewModel {
    func getUserInfomation() -> (studentName: String, username: String, faculty: String)? {
        if let credential = SSOServiceManager.shared.getCurrentCredential() {
            return (credential.studentName, credential.username, credential.faculty)
        }
        return nil
    }
    
    func getGithubLink() -> String{
        return Constant.ProfileView.githubLink
    }
    
    func getSaveDataMode() -> Bool {
        return false
    }
    
    func setSaveDataMode(isSave: Bool) {
        print(isSave)
    }
    
    func getVersion() -> String {
        // TODO: Something with apple api here
        return "Phiên bản: 1.0.0-rc"
    }
    
    func createEmailUrl() -> URL? {
        let subjectEncoded = Constant.ProfileView.emalSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = Constant.ProfileView.emailBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(Constant.ProfileView.recipentEmail)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(Constant.ProfileView.recipentEmail)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(Constant.ProfileView.recipentEmail)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(Constant.ProfileView.recipentEmail)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(Constant.ProfileView.recipentEmail)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
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
        SSOServiceManager.shared.logout {
            if $0 {
                SSOServiceManager.shared.clearMemory()
                completion()
            }
        }
    }
    
}

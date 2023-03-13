//
//  ProfileViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit
import MessageUI

final class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet private weak var userNameLabel: UILabel!
    
    @IBOutlet private weak var userMailLabel: UILabel!
    
    @IBOutlet private weak var userMajorLabel: UILabel!
    
    @IBOutlet private weak var versionLabel: UILabel!
    
    @IBOutlet private weak var policyButton: UIView!
    
    @IBOutlet private weak var externalLinkButton: UIView!
    
    @IBOutlet private weak var infoButton: UIView!
    
    @IBOutlet private weak var logoutButton: UIView!
    
    @IBOutlet private weak var appSaveDataSwitch: CustomSwitch!
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupContent()
        setupGesture()
    }
    
    private func setupContent() {
        appSaveDataSwitch.isOn = viewModel.getToggleState()
        let userInfo = viewModel.getUserInfomation()
        userNameLabel.text = userInfo.userName
        userMailLabel.text = userInfo.userMail
        userMajorLabel.text = userInfo.userMajor
        versionLabel.text = viewModel.getVersion()
    }
    
    private func setupGesture() {
        policyButton.isUserInteractionEnabled = true
        externalLinkButton.isUserInteractionEnabled = true
        infoButton.isUserInteractionEnabled = true
        logoutButton.isUserInteractionEnabled = true
        
        let policyGesture = UITapGestureRecognizer(target: self, action: #selector(self.navigateToPolicy(_:)))
        let externalLinkGesture = UITapGestureRecognizer(target: self, action: #selector(self.navigateToExternalLink(_:)))
        let informErrorGesture = UITapGestureRecognizer(target: self, action: #selector(self.informDevForError(_:)))
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(self.logout(_:)))

        policyButton.addGestureRecognizer(policyGesture)
        externalLinkButton.addGestureRecognizer(externalLinkGesture)
        infoButton.addGestureRecognizer(informErrorGesture)
        logoutButton.addGestureRecognizer(logoutGesture)
        
    }
    
    @objc func navigateToPolicy(_ sender: UITapGestureRecognizer? = nil) {
        
    }
    
    @objc func navigateToExternalLink(_ sender: UITapGestureRecognizer? = nil) {
        let link = viewModel.getGithubLink()
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func informDevForError(_ sender: UITapGestureRecognizer? = nil) {
        let recipientEmail = "maillungtung@gmail.com"
        let subject = "Multi client email support"
        let body = "I want to inform you some information about some error happenned in iOS version of myBK"
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
            
            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = viewModel.createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    @objc func logout(_ sender: UITapGestureRecognizer? = nil) {
        viewModel.logout { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

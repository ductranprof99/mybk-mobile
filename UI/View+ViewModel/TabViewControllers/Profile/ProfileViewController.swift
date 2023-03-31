//
//  ProfileViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit
import MessageUI

final class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet private weak var studentNameLabel: UILabel!
    
    @IBOutlet private weak var usernameLabel: UILabel!
    
    @IBOutlet private weak var facultyLabel: UILabel!
    
    @IBOutlet private weak var versionLabel: UILabel!
    
    @IBOutlet private weak var policyButton: UIView!
    
    @IBOutlet private weak var externalLinkButton: UIView!
    
    @IBOutlet private weak var infoButton: UIView!
    
    @IBOutlet private weak var logoutButton: UIView!
    
    @IBOutlet private weak var appSaveDataSwitch: CustomSwitch!
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupGesture()
    }
    
    private func setupContent() {
        appSaveDataSwitch.isOn = viewModel.getSaveDataMode()
        appSaveDataSwitch.toggleActionHandler = { [weak self] isSave in
            self?.viewModel.setSaveDataMode(isSave: isSave)
        }
        let userInfo = viewModel.getUserInfomation()
        studentNameLabel.text = userInfo?.studentName
        usernameLabel.text = userInfo?.username
        facultyLabel.text = userInfo?.faculty
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
        let vc = PolicyViewController.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func navigateToExternalLink(_ sender: UITapGestureRecognizer? = nil) {
        let link = viewModel.getGithubLink()
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func informDevForError(_ sender: UITapGestureRecognizer? = nil) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Constant.ProfileView.recipentEmail])
            mail.setSubject(Constant.ProfileView.emalSubject)
            mail.setMessageBody(Constant.ProfileView.emailBody, isHTML: false)
            
            present(mail, animated: true)
        } else if let emailUrl = viewModel.createEmailUrl() {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    @objc func logout(_ sender: UITapGestureRecognizer? = nil) {
        viewModel.logout {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

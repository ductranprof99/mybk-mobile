//
//  LoginViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBOutlet weak var autoCredentialButton: UIButton!
    
    @IBAction func signUpHandler(_ sender: Any) {
        viewModel.login(username: userNameField.text,
                        password: passwordField.text) { [weak self] status in
            // TODO: Doing more here, like show toast or navigate
            if status == .Successful {
                DispatchQueue.main.async {
                    self?.navigateToMainScreen()
                }
            } else {
                self?.showToast(msg: "not granted")
            }
        }
    }
    
    @IBAction func bioMetricLoginHandler(_ sender: Any) {
        viewModel.biometricLogin(completion: { [weak self] status in
            self?.showToast(msg: "Biometric fail")
        }, bioFiller: { [weak self] (username, password) in
            self?.fillInfoByBioMetric(username, password)
        })
    }
    
    @objc func navigateToPolicy() {
        let vc = PolicyViewController.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToMainScreen() {
        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(tabbarVC, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContent()
    }
    
    let viewModel = LoginViewModel()
    
    private func setupViewContent() {
        
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(navigateToPolicy))
        
        policyLabel.addGestureRecognizer(gestureRecognizer)
        
        if let iconBio = viewModel.getBioMetricUIImage() {
            autoCredentialButton.imageView?.image = iconBio
        } else {
            autoCredentialButton.isHidden = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showToast(msg: String) {
        print(msg)
    }
    
    private func fillInfoByBioMetric(_ username: String, _ password: String) {
        DispatchQueue.main.async {
            self.userNameField.text = username
            self.passwordField.text = password
        }
    }
}

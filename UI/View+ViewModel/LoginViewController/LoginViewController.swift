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
    
    @IBOutlet weak var autoCredentialButton: UIImageView!
    
    @IBAction func signUpHandler(_ sender: Any) {
        login()
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
            autoCredentialButton.image = iconBio
            let gestureRecognier = UITapGestureRecognizer(target: self, action: #selector(login))
            autoCredentialButton.addGestureRecognizer(gestureRecognier)
        } else {
            autoCredentialButton.isHidden = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func login() {
        viewModel.login(username: userNameField.text,
                        password: passwordField.text) {
            // TODO: Doing more here, like show toast or navigate
            if $0 == .Successful {
                DispatchQueue.main.async {
                    self.navigateToMainScreen()
                }
            } else {
                print("not granted")
            }
        }
    }
}

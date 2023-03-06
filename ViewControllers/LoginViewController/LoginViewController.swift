//
//  LoginViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameViewContainer: UIView!
    
    @IBOutlet weak var passwordViewContainer: UIView!
    
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBAction func signUpHandler(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(tabbarVC, animated: false)
    }
    
    @objc func navigateToPolicy() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewContent()
    }


    private func setupViewContent() {
        let userNameTextField = CustomTextField(frame: usernameViewContainer.bounds)
        userNameTextField.backgroundColor = .white
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Tên người dùng",
            attributes: [.foregroundColor: UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1),
                         .font: UIFont.systemFont(ofSize: 16)]
        )
        usernameViewContainer.addSubview(userNameTextField)
        userNameTextField.setConstrain(to: usernameViewContainer) { make in
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.top(top: 0))
            make.append(.bottom(bottom: 0))
        }
        
        let passwordTextField = CustomTextField(frame: passwordViewContainer.bounds)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Mật khẩu",
            attributes: [.foregroundColor: UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1),
                         .font: UIFont.systemFont(ofSize: 16)]
        )
        passwordViewContainer.addSubview(passwordTextField)
        passwordTextField.setConstrain(to: passwordViewContainer) { make in
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.top(top: 0))
            make.append(.bottom(bottom: 0))
        }
        
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(navigateToPolicy))
        
        policyLabel.addGestureRecognizer(gestureRecognizer)
    }
    
}

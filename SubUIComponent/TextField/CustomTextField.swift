//
//  CustomTextField.swift
//  MybkMobile
//
//  Created by DucTran on 26/02/2023.
//

import UIKit
/*
 let textField = CustomTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 48))
 textField.placeholder = "Enter your name"
 */

final class CustomTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.masksToBounds = true
        backgroundColor = UIColor.white
    }
    
}

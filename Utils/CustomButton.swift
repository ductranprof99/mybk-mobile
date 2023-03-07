//
//  CustomButton.swift
//  MybkMobile
//
//  Created by DucTran on 07/03/2023.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius(cornerRadius: cornerRadius)
        }
    }

    func updateCornerRadius(cornerRadius: CGFloat = 0.0) {
        if rounded {
            layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        } else if cornerRadius != 0 {
            layer.cornerRadius = cornerRadius
        }
    }
}

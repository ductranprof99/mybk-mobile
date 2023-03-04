//
//  UIView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit


public extension UIView {
    class func fromNib() -> Self {
        return Bundle(for: self.self).loadNibNamed(String(describing: self.self), owner: nil, options: nil)![0] as! Self
    }
    
    class func fromNib(bundle: Bundle, owner: Any? = nil) -> Self {
        return bundle.loadNibNamed(String(describing: self.self), owner: owner, options: nil)![0] as! Self
    }
    
    enum BorderPosition {
        case left
        case top
        case bottom
        case right
    }
    
    func addBorder(position: UIView.BorderPosition, color: UIColor, width: CGFloat, length: CGFloat = -1, wide wideOffSet: CGFloat = 0, offset positionOffset: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        var lengthOffset: CGFloat
        var locationOffset: CGFloat
        switch position {
        case .left, .right:
            locationOffset = (positionOffset > 0 && positionOffset < frame.size.width) ? positionOffset : 0
            lengthOffset = (length >= 0 && length < frame.size.width) ? (frame.size.width - length)/2 : 0
        case .top , .bottom:
            locationOffset = (positionOffset > 0 && positionOffset < frame.size.height) ? positionOffset : 0
            lengthOffset = (length >= 0 && length < frame.size.height) ? (frame.size.height - length)/2 : 0
        }
        lengthOffset = (lengthOffset != 0) ? lengthOffset : wideOffSet
        switch position {
        case .left:
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
            border.frame = CGRect(x: locationOffset, y: lengthOffset, width: width, height: frame.size.height - lengthOffset)
            break
        case .top:
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            border.frame = CGRect(x: lengthOffset, y: locationOffset, width: frame.size.width - lengthOffset, height: width)
            break
        case .bottom:
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            border.frame = CGRect(x: lengthOffset , y: frame.size.height - width - locationOffset, width: frame.size.width - lengthOffset, height: width)
            break
        case .right:
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            border.frame = CGRect(x: frame.size.width - width - locationOffset, y: lengthOffset, width: width, height: frame.size.height - lengthOffset)
            break
        }
        addSubview(border)
    }
    
    func border(radius: CGFloat = 4,
                       color: UIColor = .gray,
                       width: CGFloat = 1) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

}

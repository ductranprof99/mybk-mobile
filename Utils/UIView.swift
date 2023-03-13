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
    
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
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


extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {

            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
}

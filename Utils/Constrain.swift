//
//  Constrain.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

extension UIView {
    
    enum ConstrainStyle {
        case trailing (trailing : CGFloat)
        case leading (leading : CGFloat)
        case top (top : CGFloat)
        case bottom (bottom : CGFloat)
        case centerX (centerX : CGFloat)
        case centerY (centerY : CGFloat)
        case width (width : CGFloat)
        case height (height : CGFloat)
    }
    
    
    func setConstrain(to relatedView: UIView, completion: (inout [ConstrainStyle]) -> Void ) {
        var constraintData = [ConstrainStyle]()
        completion(&constraintData)
        var constraints = [NSLayoutConstraint]()
        if constraintData.isEmpty { return }
        for i in constraintData {
            var c: NSLayoutConstraint? = nil
            switch i {
            case .trailing(trailing: let trailing):
                c = self.trailingAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.trailingAnchor, constant: trailing)
            case .leading(leading: let leading):
                c = self.leadingAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.leadingAnchor, constant: leading)
            case .top(top: let top):
                c = self.topAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.topAnchor, constant: top)
            case .bottom(bottom: let bottom):
                c = self.bottomAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
            case .centerX(centerX: let centerX):
                c = self.trailingAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.trailingAnchor, constant: centerX)
            case .centerY(centerY: let centerY):
                c = self.centerYAnchor.constraint(equalTo: relatedView.safeAreaLayoutGuide.centerYAnchor, constant: centerY)
            case .width(width: let width):
                c = self.widthAnchor.constraint(equalToConstant: width)
            case .height(height: let height):
                c = self.heightAnchor.constraint(equalToConstant: height)
            }
            constraints.append(c!)
        }
        NSLayoutConstraint.activate(constraints)
    }
}

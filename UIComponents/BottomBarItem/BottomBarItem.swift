//
//  BottomBarItem.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class BottomBarItem: UIView {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var itemImage: UIImageView!
    @IBOutlet private var itemLabel: UILabel!
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.containerView)
        setupItemConstrain()
        setupGesture()
    }
    
    private func setupItemConstrain() {
        containerView.setConstrain(to: self) { make in
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
            make.append(.trailing(trailing: 0))
            make.append(.leading(leading: 0))
        }
    }
    
    private func setupGesture() {
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGesture))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func tapGesture() {
        onTap?()
    }
    
    public func setItemContent(image: UIImage, text labelText: String){
        self.itemImage.image = image
        self.itemLabel.text = labelText
    }
}

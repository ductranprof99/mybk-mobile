//
//  SettingCell.swift
//  MybkMobile
//
//  Created by DucTran on 04/03/2023.
//

import UIKit

class SettingCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var settingTitle: UILabel!
    
    @IBOutlet weak var buttonHolderView: UIView!
    
    @IBOutlet weak var settingDetail: UILabel!
    
    public var isContentTouch: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gestureRecoginizer = UITapGestureRecognizer.init(target: self, action: #selector(tapSettingBackground))
        backgroundImage.addGestureRecognizer(gestureRecoginizer)
        buttonHolderView.isHidden = true
        settingDetail.isHidden = true
    }
    
    public func setUpSettingContent(title: String, detail: String?) {
        if let detail = detail {
            settingDetail.text = detail
            settingDetail.isHidden = false
        }
        settingTitle.text = title
    }
    
    @objc private func tapSettingBackground() {
        self.isContentTouch?()
    }
    
    public func setButtonView(with view: UIView){
        buttonHolderView.isHidden = false
        buttonHolderView.addSubview(view)
        view.setConstrain(to: buttonHolderView) { make in
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
            make.append(.trailing(trailing: 0))
            make.append(.leading(leading: 0))
        }
    }

}

//
//  InfoDetailCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

class InfoDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var crucialInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addBorder(position: .top, color: UIColor(rgb: 0xDEDEDE), width: 1)
    }

    public func setContent(title: String,
                           content: String? = nil,
                           crucialInfo: String? = nil) {
        titleLabel.text = title
        if let content = content {
            contentLabel.text = content
        } else {
            contentLabel.isHidden = true
        }
        if let crucialInfo = crucialInfo {
            crucialInfoLabel.text = crucialInfo
        } else {
            crucialInfoLabel.isHidden = true
        }
    }
    
}

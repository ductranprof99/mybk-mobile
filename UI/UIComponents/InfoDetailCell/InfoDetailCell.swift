//
//  InfoDetailCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

final class InfoDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var crucialInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setContent(title: String,
                           content: String = "",
                           crucialInfo: String = "") {
        titleLabel.text = title
        contentLabel.text = content
        crucialInfoLabel.text = crucialInfo
        
    }
    
}


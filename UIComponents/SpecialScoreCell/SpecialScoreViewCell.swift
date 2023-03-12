//
//  SpecialScoreViewCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

class SpecialScoreViewCell: UITableViewCell {

    @IBOutlet weak var pointTypeTitle: UILabel!
    
    @IBOutlet weak var pointTypeDetail: UILabel!
    
    @IBOutlet weak var specialPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addBorder(position: .top, color: UIColor(rgb: 0xDEDEDE), width: 1)
    }
    
    public func setContent(title: String, detail: String, point: String) {
        pointTypeTitle.text = title
        pointTypeDetail.text = detail
        specialPoint.text = point
    }
    
}

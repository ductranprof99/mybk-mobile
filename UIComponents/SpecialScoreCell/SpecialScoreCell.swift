//
//  SpecialScoreCell.swift
//  MybkMobile
//
//  Created by DucTran on 04/03/2023.
//

import UIKit

class SpecialScoreCell: UICollectionViewCell {

    @IBOutlet weak var pointTypeTitle: UILabel!
    
    @IBOutlet weak var pointTypeDetail: UILabel!
    
    @IBOutlet weak var specialPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setContent(title: String, detail: String, point: String) {
        pointTypeTitle.text = title
        pointTypeDetail.text = detail
        specialPoint.text = point
    }

}

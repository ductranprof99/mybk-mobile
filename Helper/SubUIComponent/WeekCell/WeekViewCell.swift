//
//  WeekViewCell.swift
//  MybkMobile
//
//  Created by DucTran on 27/03/2023.
//

import UIKit

final class WeekViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var cellContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCellContent(week: String) {
        if week.contains("-") {
            cellBackgroundView.backgroundColor = .white
            cellContent.textColor = UIColor(rgb: 0xCECECE)
        } else {
            cellBackgroundView.backgroundColor = UIColor(rgb: 0x1297C1).withAlphaComponent(0.2)
            cellContent.textColor = UIColor(rgb: 0x1297C1)
        }
        cellContent.text = week
    }

}

//
//  SubjectScheduleCell.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import UIKit

final class SubjectScheduleCell: UICollectionViewCell {
    
    static let cellHeight: CGFloat = 200

    @IBOutlet private weak var subjectNameLabel: UILabel!
    
    @IBOutlet private weak var subjectCodeLabel: UILabel!
    
    @IBOutlet private weak var classLabel: UILabel!
    
    @IBOutlet private weak var creditLabel: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
    @IBOutlet private weak var bottomContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

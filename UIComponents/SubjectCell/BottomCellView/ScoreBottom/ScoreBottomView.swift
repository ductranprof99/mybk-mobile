//
//  ScoreBottomView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class ScoreBottomView: UIView {
    
    @IBOutlet private var periodScoreLabel: UILabel!
    @IBOutlet private var finalTestLabel: UILabel!
    @IBOutlet private var finalScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setContent(data cellData: SubjectCellType) {
        if case let .scoreBottot(data) = cellData {
            periodScoreLabel.text = data.periodScore
            finalTestLabel.text = data.finalTermScore
            finalScoreLabel.text = data.finalScore
        }
    }
}

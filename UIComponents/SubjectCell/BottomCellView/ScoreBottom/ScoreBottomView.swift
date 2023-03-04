//
//  ScoreBottomView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class ScoreBottomView: UIView {
    
    @IBOutlet private var containerView: UIView!
    
    @IBOutlet private var periodScoreLabel: UILabel!
    @IBOutlet private var finalTestLabel: UILabel!
    @IBOutlet private var finalScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(containerView)
        containerView.setConstrain(to: self) { make in
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
        }
    }
    
    public func setContent(data cellData: SubjectCellType) {
        if case let .scoreBottot(data) = cellData {
            periodScoreLabel.text = data.periodScore
            finalTestLabel.text = data.finalTermScore
            finalScoreLabel.text = data.finalScore
        }
    }
}

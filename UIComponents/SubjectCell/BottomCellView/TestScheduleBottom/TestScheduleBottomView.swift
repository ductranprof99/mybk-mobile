//
//  TestScheduleBottomView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class TestScheduleBottomView: UIView {
    
    @IBOutlet private var midTermDateLabel: UILabel!
    @IBOutlet private var midTermTimeLabel: UILabel!
    @IBOutlet private var midTermLocationLabel: UILabel!
    
    @IBOutlet private var endTermDateLabel: UILabel!
    @IBOutlet private var endTermTimeLabel: UILabel!
    @IBOutlet private var endTermLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setContent(data cellData: SubjectCellType) {
        if case let .testBottom(data) = cellData {
            midTermDateLabel.text = data.midTermTestInfo.date
            midTermTimeLabel.text = data.midTermTestInfo.time
            midTermLocationLabel.text = data.midTermTestInfo.location
            endTermDateLabel.text = data.endTermTestInfo.date
            endTermTimeLabel.text = data.endTermTestInfo.time
            endTermLocationLabel.text = data.endTermTestInfo.location
        }
    }
}

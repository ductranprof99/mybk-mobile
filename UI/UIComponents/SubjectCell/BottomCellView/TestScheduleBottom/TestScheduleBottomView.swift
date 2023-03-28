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
        if case let .examBottom(data) = cellData {
            midTermDateLabel.text = data.midTermExamDate
            midTermTimeLabel.text = data.midTermExamTime
            midTermLocationLabel.text = data.midTermExamLocation
            endTermDateLabel.text = data.endTermExamDate
            endTermTimeLabel.text = data.endTermExamTime
            endTermLocationLabel.text = data.endTermExamLocation
        }
    }
}

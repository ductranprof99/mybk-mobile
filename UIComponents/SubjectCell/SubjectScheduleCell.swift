//
//  SubjectScheduleCell.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import UIKit

enum SubjectCellType {
    case scoreBottom(data: SubjectCellModel)
    case testBottom(data: SubjectCellModel)
    case schedBottom(data: SubjectCellModel)
}

final class SubjectScheduleCell: CustomCell {
    
    @IBOutlet private weak var subjectNameLabel: UILabel!
    
    @IBOutlet private weak var subjectCodeLabel: UILabel!
    
    @IBOutlet private weak var classLabel: UILabel!
    
    @IBOutlet private weak var creditLabel: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
    @IBOutlet private weak var bottomContainerView: UIView!
    
    @IBOutlet private weak var topContainerView: UIView!
    
    private var learningSchedBottomView: LearnScheduleBottomView = .fromNib()
    
    private var testSceduleBottomView: TestScheduleBottomView = .fromNib()
    
    private var scoreBottomView: ScoreBottomView = .fromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topContainerView.addBorder(position: .bottom, color: .init(rgb: 0xF7F7F7), width: 1)
    }

    public func setCellContent(cellData: SubjectCellType) {
        setTopView(data: cellData)
        switch cellData {
        case .scoreBottom:
            addBottomView(view: scoreBottomView)
            scoreBottomView.setContent(data: cellData)
        case .testBottom:
            addBottomView(view: testSceduleBottomView)
            testSceduleBottomView.setContent(data: cellData)
        case .schedBottom:
            addBottomView(view: learningSchedBottomView)
            learningSchedBottomView.setContent(data: cellData)
        }
    }
    
    private func addBottomView(view: UIView) {
        bottomContainerView.addSubview(view)
        view.setConstrain(to: bottomContainerView) { make in
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
        }
    }
    
    private func setTopView(data: SubjectCellType) {
        switch data {
        case .scoreBottom(let data), .testBottom(let data):
            self.subjectNameLabel.text = data.subjectName
            self.subjectCodeLabel.text = data.subjectCode
            self.classLabel.text = data.classRoomCode
            self.creditLabel.isHidden = true
            self.detailButton.isHidden = true
        case .schedBottom(let data):
            self.subjectNameLabel.text = data.subjectName
            self.subjectCodeLabel.text = data.subjectCode
            self.classLabel.text = data.classRoomCode
            self.creditLabel.text = data.credit
        }
    }
}

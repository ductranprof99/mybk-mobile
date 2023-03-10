//
//  SubjectScheduleCell.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import UIKit

enum SubjectCellType {
    case scoreBottot(data: SubjectCellModel)
    case testBottom(data: SubjectCellModel)
    case schedBottom(data: SubjectCellModel)
}

final class SubjectScheduleCell: CustomCell {
    
    static let cellHeight: CGFloat = 200

    @IBOutlet private weak var subjectNameLabel: UILabel!
    
    @IBOutlet private weak var subjectCodeLabel: UILabel!
    
    @IBOutlet private weak var classLabel: UILabel!
    
    @IBOutlet private weak var creditLabel: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
    @IBOutlet private weak var bottomContainerView: UIView!
    
    @IBOutlet private weak var topContainerView: UIView!
    
    private lazy var learningSchedBottomView: LearnScheduleBottomView = {
        return .init(frame: self.bottomContainerView.bounds)
    }()
    
    private lazy var testSceduleBottomView: TestScheduleBottomView = {
        return .fromNib()
    }()
    
    private lazy var scoreBottomView: ScoreBottomView = {
        return .fromNib()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setCellContent(cellData: SubjectCellType) {
        setTopView(data: cellData)
        switch cellData {
        case .scoreBottot:
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
        case .scoreBottot(let data), .testBottom(let data):
            self.subjectNameLabel.text = data.subjectName
            self.subjectCodeLabel.text = data.subjectCode
            self.classLabel.text = data.classRoomCode
            self.creditLabel.isHidden = true
        case .schedBottom(let data):
            self.subjectNameLabel.text = data.subjectName
            self.subjectCodeLabel.text = data.subjectCode
            self.classLabel.text = data.classRoomCode
            self.creditLabel.text = data.credit
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(
            width: targetSize.width,
            height: 210
        )
    }
    
}

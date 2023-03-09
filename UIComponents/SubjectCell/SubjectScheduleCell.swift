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

final class SubjectScheduleCell: UICollectionViewCell {
    
    static let cellHeight: CGFloat = 200

    @IBOutlet private weak var subjectNameLabel: UILabel!
    
    @IBOutlet private weak var subjectCodeLabel: UILabel!
    
    @IBOutlet private weak var classLabel: UILabel!
    
    @IBOutlet private weak var creditLabel: UILabel!
    
    @IBOutlet private weak var detailButton: UIButton!
    
    @IBOutlet private weak var bottomContainerView: UIView!
    
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
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
}

//
//  LearnScheduleBottomView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class LearnScheduleBottomView: UIView {
    
    @IBOutlet private var weekDayLabel:UILabel!
    @IBOutlet private var hoursLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(WeekViewCell.self)
    }
    
    var data: CourseScheduleRemoteData? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public func setContent(data cellData: SubjectCellType) {
        if case let .schedBottom(data) = cellData {
            self.weekDayLabel.text = (data.lessonDate != nil) ? "Thứ \(data.lessonDate!)" : Constant.LearnScheduleView.all
            self.hoursLabel.text = "\(data.timeStart ?? "") - \(data.timeEnd ?? "")"
            self.locationLabel.text = data.locationCode.rawValue
            self.data = data
        }
    }
    
}

extension LearnScheduleBottomView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(WeekViewCell.self, for: indexPath)
        if let cellData = data?.weekSchedule,
           indexPath.item < cellData.count {
            cell.setCellContent(week: cellData[indexPath.item] )
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.weekSchedule.count ?? 0
    }
    
}

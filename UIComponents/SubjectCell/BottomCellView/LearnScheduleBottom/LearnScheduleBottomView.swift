//
//  LearnScheduleBottomView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

final class LearnScheduleBottomView: UIView {
    @IBOutlet private var containerView: UIView!
    
    @IBOutlet private var weekDayLabel:UILabel!
    @IBOutlet private var hoursLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("LearnScheduleBottomView", owner: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(containerView)
        containerView.setConstrain(to: self) { make in
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
        }
        
        // TODO: add register
//        collectionView.register(UICollectionViewCell.self)
    }
    
    // TODO: fix type here
    var data: SubjectCellModel? {
        didSet {
//            collectionView.performBatchUpdates {
//                collectionView.reloadData()
//            }
        }
    }
    
    public func setContent(data cellData: SubjectCellType) {
        if case let .schedBottom(data) = cellData {
            self.weekDayLabel.text = data.weekDay
            self.hoursLabel.text = data.hours
            self.locationLabel.text = data.location
            self.data = data
        }
    }
    
}

extension LearnScheduleBottomView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.activeWeek.count ?? 0
    }
    
}

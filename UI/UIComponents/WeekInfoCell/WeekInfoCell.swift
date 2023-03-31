//
//  WeekInfoCell.swift
//  MybkMobile
//
//  Created by DucTran on 31/03/2023.
//

import Foundation
import UIKit

final class WeekInfoCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(rgb: 0x11425E)
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 30, height: 20)
        layout.minimumLineSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(WeekViewCell.self)
        collection.backgroundColor = UIColor(rgb: 0xF7F7F7)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(rgb: 0xF7F7F7)
        contentView.addSubview(self.collection)
        contentView.addSubview(self.titleLabel)
        self.collection.delegate = self
        self.collection.dataSource = self
        
        titleLabel.setConstrain(to: contentView) { make in
            make.append(.leading(leading: 0))
            make.append(.centerY(centerY: 0))
        }
        
        collection.setConstrain(to: contentView) { make in
            make.append(.centerY(centerY: 0))
            make.append(.trailing(trailing: 20))
            make.append(.height(height: 30))
        }
        
        let titleConstrain = titleLabel.trailingAnchor.constraint(equalTo: collection.leadingAnchor, constant: -20)
        titleConstrain.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionViewData: [String]? {
        didSet {
            self.collection.reloadData()
        }
    }
    
    public func setContent(title: String,
                           schedule: [String]? = nil) {
        titleLabel.text = title
        self.collectionViewData = schedule
    }
    
}

extension WeekInfoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(WeekViewCell.self, for: indexPath)
        if let cellData = collectionViewData,
           indexPath.item < cellData.count {
            cell.setCellContent(week: cellData[indexPath.item] )
        }
        return cell
    }
    
}

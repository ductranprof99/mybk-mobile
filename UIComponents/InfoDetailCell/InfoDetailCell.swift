//
//  InfoDetailCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

final class InfoDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var crucialInfoLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addBorder(position: .top, color: UIColor(rgb: 0xDEDEDE), width: 1)
        collectionView.register(UICollectionViewCell.self)
    }

    public func setContent(title: String,
                           content: String? = nil,
                           crucialInfo: String? = nil,
                           schedule: [String]? = nil) {
        titleLabel.text = title
        if let content = content {
            contentLabel.text = content
        } else {
            contentLabel.isHidden = true
        }
        if let crucialInfo = crucialInfo {
            crucialInfoLabel.text = crucialInfo
        } else {
            crucialInfoLabel.isHidden = true
        }
        if let schedule = schedule {
            self.collectionViewData = schedule
        } else {
            collectionView.isHidden = true
        }
    }
    
    var collectionViewData: [String]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
}

extension InfoDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(UICollectionViewCell.self,for: indexPath)
    }
    
}


//
//  TranscriptCollectionViewHeaderCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

class TranscriptCollectionViewHeaderCell: UICollectionReusableView {

    
    var tableView: UITableView = .init()
    var viewModel: TranscriptHeaderModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        tableView.setConstrain(to: self) { make in
            make.append(.bottom(bottom: 0))
            make.append(.top(top: 0))
            make.append(.trailing(trailing: 0))
            make.append(.leading(leading: 0))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoDetailCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpContent(viewModel: TranscriptHeaderModel) {
        self.viewModel = viewModel
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        return .init(width: targetSize.width,
//                     height: self.tableView.contentSize.height)
//    }
}

extension TranscriptCollectionViewHeaderCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = viewModel?.getSectionData(section: section) else { return 0 }
        return sectionData.numOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel?.getSectionData(section: indexPath.section)?.dataOfRow(in: indexPath.item)
        let cell = tableView.dequeueReusableCell(of: InfoDetailCell.self, for: indexPath) { cell in
            cell.setContent(title: cellData?.title ?? "No title == foul", content: cellData?.detail,crucialInfo: cellData?.crucial)
        }
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(rgb: 0x1297C1)
        label.text = viewModel?.getSectionData(section: section)?.title
        view.addSubview(label)
        label.setConstrain(to: view) { make in
            make.append(.centerY(centerY: 0))
            make.append(.leading(leading: 24))
            make.append(.trailing(trailing: 24))
        }
        return view
    }
}

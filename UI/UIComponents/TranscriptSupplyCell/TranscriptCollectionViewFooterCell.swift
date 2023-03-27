//
//  TranscriptCollectionViewFooterCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

final class TranscriptCollectionViewFooterCell: UICollectionReusableView {

    var tableView: UITableView = .init()
    var viewModel: TranscriptFooterModel? {
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
            make.append(.trailing(trailing: 10))
            make.append(.leading(leading: 10))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SpecialScoreViewCell.self)
        tableView.separatorColor = .clear
        tableView.backgroundColor = UIColor(rgb: 0xF7F7F7)
        tableView.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpContent(viewModel: TranscriptFooterModel) {
        self.viewModel = viewModel
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return .init(width: targetSize.width,
                     height: self.tableView.contentSize.height)
    }
    
    override func layoutSubviews() {
        tableView.frame.size = tableView.contentSize
        super.layoutSubviews()
    }
}

extension TranscriptCollectionViewFooterCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel?.getSectionData(in: indexPath.item)
        let cell = tableView.dequeueReusableCell(of: SpecialScoreViewCell.self, for: indexPath) { cell in
            cell.setContent(title: cellData?.title ?? "no data",
                            detail: cellData?.detail ?? "no data",
                            point: cellData?.point ?? "no data")
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
        label.text = viewModel?.getTitle()
        view.addSubview(label)
        label.setConstrain(to: view) { make in
            make.append(.centerY(centerY: 0))
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


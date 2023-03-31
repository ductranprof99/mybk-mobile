//
//  TranscriptCollectionViewHeaderCell.swift
//  MybkMobile
//
//  Created by DucTran on 12/03/2023.
//

import UIKit

final class TranscriptCollectionViewHeaderCell: UICollectionReusableView {

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
            make.append(.trailing(trailing: 10))
            make.append(.leading(leading: 10))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoDetailCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0xF7F7F7)
        tableView.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpContent(viewModel: TranscriptHeaderModel) {
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

extension TranscriptCollectionViewHeaderCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = HeaderSectionType(rawValue: section),
              let sectionData = viewModel?.getSectionData(section: sectionType) else { return 0 }
        switch sectionData {
        case .summarize(let info):
            return info?.count ?? 0
        case .scholarship(let info):
            return info?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if let sectionType = HeaderSectionType(rawValue: indexPath.section),
           let sectionData = viewModel?.getSectionData(section: sectionType) {
            cell = tableView.dequeueReusableCell(of: InfoDetailCell.self, for: indexPath) { cell in
                switch sectionData {
                case .summarize(let info), .scholarship(let info):
                    cell.setContent(title: info?[indexPath.item].title ?? "No title == foul",
                                    crucialInfo: info?[indexPath.item].detail ?? "")
                }
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        guard let sectionType =  HeaderSectionType(rawValue: section) else { return nil }
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(rgb: 0x1297C1)
        label.text = viewModel?.getSectionTitle(section: sectionType)
        view.addSubview(label)
        label.setConstrain(to: view) { make in
            make.append(.centerY(centerY: 0))
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//
//  DetailSubjectViewController.swift
//  MybkMobile
//
//  Created by DucTran on 14/03/2023.
//

import UIKit

final class DetailSubjectViewController: UIViewController {

    @IBOutlet private weak var itemTitle: UILabel!
    @IBOutlet private weak var subjectNameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupContent()
    }
    
    var viewModel: DetailSubjectViewModel? = nil
    
    private func setupContent() {
        if self.viewModel != nil {
            tableView.register(InfoDetailCell.self)
            self.tableView.reloadData()
            self.subjectNameLabel.text = self.viewModel?.getSubjectName()
            self.itemTitle.text = self.viewModel?.getSubjectType()
        }
    }
    
    
}

extension DetailSubjectViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = viewModel?.getData(of: indexPath.section) else { return UITableViewCell() }
        if let cellInfo = cellData.info as? String {
            let cell = tableView.dequeueReusableCell(of: InfoDetailCell.self, for: indexPath) { cell in
                cell.setContent(title: cellData.title ,
                                    content: cellInfo)
            }
            return cell ?? UITableViewCell()
        } else if let schedule = cellData.info as? [String] {
            let cell = tableView.dequeueReusableCell(of: InfoDetailCell.self, for: indexPath) { cell in
                cell.setContent(title: cellData.title ,schedule: schedule)
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

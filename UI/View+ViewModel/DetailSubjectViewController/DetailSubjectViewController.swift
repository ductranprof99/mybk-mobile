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
    @IBOutlet weak var navigationItems: UINavigationItem!
    
    @IBAction func backButtonHandler(_ sender: Any) {
        viewModel = nil
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(InfoDetailCell.self)
        tableView.register(WeekInfoCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.subjectNameLabel.text = self.viewModel?.getSubjectName()
        self.itemTitle.text = self.viewModel?.getSubjectType()
        self.navigationItems.title = self.viewModel?.getSubjectCode()
    }
    
    var viewModel: DetailSubjectViewModel? = nil
}

extension DetailSubjectViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = viewModel?.getData(of: indexPath.item) else { return UITableViewCell() }
        var cell: UITableViewCell?
        if let schedule = cellData.info as? [String] {
            let currCell = tableView.dequeueReusableCell(of: WeekInfoCell.self, for: indexPath)
            currCell?.setContent(title: cellData.title ,schedule: schedule)
            cell = currCell
        } else if let info = cellData.info as? String {
            let currCell = tableView.dequeueReusableCell(of: InfoDetailCell.self, for: indexPath)
            currCell?.setContent(title: cellData.title ,
                             content: info)
            cell = currCell
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

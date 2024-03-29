//
//  ScheduleViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var pickerButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func pickerTapHandler(_ sender: Any) {
        let vc = UIViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(pickerView)
        pickerView.setConstrain(to: vc.view) { make in
            make.append(.centerY(centerY: 0))
            make.append(.leading(leading: 0))
            make.append(.trailing(trailing: 0))
            make.append(.height(height: 200))
        }
        
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerButton
        alert.popoverPresentationController?.sourceRect = pickerButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: Constant.MainTabView.popUpSeletectButtonTitle, style: .default, handler: { [weak self] (UIAlertAction) in
            if let semeterIndex = self?.viewModel.getSelectedSemeterIndex(),
               let buttonInfo = self?.viewModel.getSemeter(at: semeterIndex) {
                self?.pickerView.selectRow(semeterIndex, inComponent: 0, animated: true)
                self?.pickerButton.setTitle(buttonInfo.semeterName ?? "error", for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
    }
    
    private func setupViewModel() {
        viewModel.updatePickerView =  { _ in
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
                if let buttonInfo = self.viewModel.getSemeter(at: 0) {
                    self.pickerView.selectRow(0, inComponent: 0, animated: true)
                    self.pickerButton.setTitle(buttonInfo.semeterName ?? "error", for: .normal)
                }
                self.collectionView.reloadData()
            }
        }
        // TODO: Call view model to trigger model auto update
        // Fix later
        viewModel.getListRemoteSemeter()
    }
    
    private func setupCollectionView() {
        // layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                                 height: 185)
        layout.footerReferenceSize = .init(width:collectionView.safeAreaLayoutGuide.layoutFrame.width,
                                           height: 50)
        layout.minimumLineSpacing = 15
        collectionView!.collectionViewLayout = layout
        // cell
        collectionView.register(SubjectScheduleCell.self)
        collectionView.register(footer: UpdateDateFooterView.self)
    }
    
    public let viewModel = ScheduleViewModel()
}

extension ScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfSubjectInSemeter(in: viewModel.getSelectedSemeterIndex())
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(SubjectScheduleCell.self,for: indexPath)
        if let cellData = viewModel.getSubjectAtIndex(in: viewModel.getSelectedSemeterIndex(), with: indexPath.item) {
            cell.setCellContent(cellData: .schedBottom(data: cellData))
            cell.handleCellTap = { [weak self] vc in
                vc.viewModel = .init(data: cellData)
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeue(footer: UpdateDateFooterView.self, forIndexPath: indexPath)
            let updateDate = viewModel.getSemeter(at: viewModel.getSelectedSemeterIndex())?.updateDate
            footerView.setUpdateDate(date: updateDate)
            return footerView
        } else {
            return UICollectionReusableView()
        }
    }
}

extension ScheduleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.getNumOfPickerItem()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 20, height: 30))
        if viewModel.getNumOfPickerItem() > 0 {
            label.text = viewModel.getSemeter(at: row)?.semeterName
        }
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setSemeterIndex(index: row)
    }
}

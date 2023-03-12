//
//  TranscriptViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit

final class TranscriptViewController: UIViewController {
    
    @IBOutlet weak var pickerButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func pickerTapHandler(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: self.view.bounds.width,
                                         height: self.view.bounds.height)
        let pickerView = UIPickerView(frame: .init(x: 0,
                                                   y: 0,
                                                   width: view.bounds.width,
                                                   height: 100))
        pickerView.dataSource = self
        pickerView.delegate = self
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerButton
        alert.popoverPresentationController?.sourceRect = pickerButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Chọn học kì", style: .default, handler: { [weak self] (UIAlertAction) in
            if let selectedRow = self?.viewModel.currentSelectedRow,
               let buttonName = self?.viewModel.getListSemeter()[selectedRow] {
                pickerView.selectedRow(inComponent: selectedRow)
                self?.pickerButton.setTitle(buttonName, for: .normal)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupCollectionView()
    }
    
    private func setupPickerView() {
        // select 1st item in row when init
    }
    
    private func setupCollectionView() {
        // layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                                 height: 185)
        layout.headerReferenceSize = CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                                            height: 600)
        layout.footerReferenceSize = CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                                            height: 600)
        layout.minimumLineSpacing = 15
        collectionView!.collectionViewLayout = layout
        // cell
        collectionView.register(SubjectScheduleCell.self)
        collectionView.register(header: TranscriptCollectionViewHeaderCell.self)
        collectionView.register(footer: TranscriptCollectionViewFooterCell.self)
    }
    
    public let viewModel = TranscriptViewModel()
}

extension TranscriptViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(SubjectScheduleCell.self,for: indexPath)
        cell.setCellContent(cellData: .scoreBottom(data: .init()))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeue(header: TranscriptCollectionViewHeaderCell.self, forIndexPath: indexPath)
            header.setUpContent(viewModel: viewModel.getHeaderSectionData())
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeue(footer: TranscriptCollectionViewFooterCell.self, forIndexPath: indexPath)
            footer.setUpContent(viewModel: viewModel.getFooterSectionData())
            return footer
        default:
            preconditionFailure("Invalid supplementary view type for this collection view")
        }
    }
    
}

extension TranscriptViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            label.text = viewModel.getListSemeter()[row]
        }
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // bind model here
        let _ = self.viewModel.updateListSchedule {
            self.collectionView.performBatchUpdates({
                    self.collectionView.reloadData()
            }, completion: { _ in
                self.collectionView.invalidateIntrinsicContentSize()
            })
        }
        
    }
    
}

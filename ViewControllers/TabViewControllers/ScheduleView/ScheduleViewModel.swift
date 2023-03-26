//
//  ScheduleViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 09/03/2023.
//

import Foundation

final class ScheduleViewModel {
    
    var updatePickerView: (([SemeterScheduleModel]?) -> Void)?
    
    // this for demo, cus when sync you need to sync with remote (in background) then convert
    // to local storage, you always get data from local storage
    private var listSemeter: [SemeterScheduleModel]? {
        didSet {
            updatePickerView?(listSemeter)
        }
    }
    private var currentSelectedRow: Int = 0
    private var subjectCellData: [SubjectCellModel]?
    
    public func getListSemeter() {
        // call api here
        if let mybkToken = SSOServiceManager.shared.mybkToken {
            RemoteSchedule.shared.getSchedules(token: mybkToken) { [weak self] result in
                switch result {
                case .success(let listSched):
                    self?.listSemeter = listSched
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func getNumOfPickerItem() -> Int {
        return self.listSemeter?.count ?? 0
    }
    
    public func getSelectedRow() -> Int {
        return currentSelectedRow
    }
    
    public func setSelectedRow(index: Int) {
        self.currentSelectedRow = index
    }
    
    public func getSelectedSemeter(index: Int) -> SemeterScheduleModel? {
        if let listSemeter = listSemeter {
            return listSemeter[index]
        }
        return nil
    }
}

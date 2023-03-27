//
//  ExamViewViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 11/03/2023.
//

import Foundation

final class ExamViewViewModel {
    var listSemeter: [String]? = ["ba", "ba", "ba", "ba"]
    var currentSelectedRow: Int = 0
    var subjectCellData: [SubjectCellModel]?
    
    public func getListSemeter() -> [String] {
        if let listSemeter = listSemeter {
            return listSemeter
        } else {
            // call api here
            return []
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
    
    public func getListSchedule(completion: @escaping ()-> Void) -> Int {
        if let subjectCellData = subjectCellData {
            completion()
            return subjectCellData.count
        } else {
            // call api here
            subjectCellData = updateListSchedule {
                
            }
            return  10
        }
    }
    
    public func updateListSchedule(completion: () -> Void) -> [SubjectCellModel] {
        // request here
        return []
    }
}

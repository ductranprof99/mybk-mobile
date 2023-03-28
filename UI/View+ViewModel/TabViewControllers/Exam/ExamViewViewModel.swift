//
//  ExamViewViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 11/03/2023.
//

import Foundation

final class ExamViewViewModel {
    var updatePickerView: (([ExamRemoteData]?) -> Void)?
    
    // this for demo, cus when sync you need to sync with remote (in background) then convert
    // to local storage, you always get data from local storage
    private var listSemeter: [ExamRemoteData]? {
        didSet {
            updatePickerView?(listSemeter)
        }
    }
    private var currentSemeterIndex: Int = 0
}

// MARK: - Get
extension ExamViewViewModel {
    public func getListRemoteSemeter() {
        // call api here
        if let mybkToken = SSOServiceManager.shared.mybkToken {
            RemoteExam.shared.getExams(token: mybkToken) { [weak self] result in
                switch result {
                case .success(let listSched):
                    self?.listSemeter = listSched
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func getNumberOfSubjectInSemeter(in index: Int) -> Int {
        return listSemeter?[index].exams?.count ?? 0
    }
    
    public func getListSubjectInSemeter(in index: Int) -> [CourseExamRemoteData] {
        return listSemeter?[index].exams ?? []
    }
    
    public func getSubjectAtIndex(in semeterIndex: Int, with courseIndex: Int) -> CourseExamRemoteData? {
        return listSemeter?[semeterIndex].exams?[courseIndex]
    }
    
    public func getSubjectCount(at index: Int) -> Int {
        return listSemeter?[index].exams?.count ?? 0
    }
    
    public func getNumOfPickerItem() -> Int {
        return listSemeter?.count ?? 0
    }
    
    public func getSelectedSemeterIndex() -> Int {
        return currentSemeterIndex
    }
    
    public func getSemeter(at index: Int) -> ExamRemoteData? {
        return listSemeter?[index]
    }
}

// MARK: - Set
extension ExamViewViewModel {
    public func setSemeterIndex(index: Int) {
        self.currentSemeterIndex = index
    }
}

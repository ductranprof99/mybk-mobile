//
//  TranscriptViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 11/03/2023.
//

import Foundation

final class TranscriptViewModel {
    
    var updatePickerView: (([GradeRemoteData]?) -> Void)?
    
    // this for demo, cus when sync you need to sync with remote (in background) then convert
    // to local storage, you always get data from local storage
    private var listSemeter: [GradeRemoteData]? {
        didSet {
            updatePickerView?(listSemeter)
        }
    }
    private var currentSemeterIndex: Int = 0
}

// MARK: - Get
extension TranscriptViewModel {
    public func getListRemoteSemeter() {
        // call api here
        if let mybkToken = SSOServiceManager.shared.mybkToken {
            RemoteGrade.shared.getGrades(token: mybkToken) { [weak self] result in
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
        return listSemeter?[index].scores?.count ?? 0
    }
    
    public func getListSubjectInSemeter(in index: Int) -> [CourseGradeRemoteData] {
        return listSemeter?[index].scores ?? []
    }
    
    public func getSubjectAtIndex(in semeterIndex: Int, with courseIndex: Int) -> CourseGradeRemoteData? {
        return listSemeter?[semeterIndex].scores?[courseIndex]
    }
    
    public func getSubjectCount(at index: Int) -> Int {
        return listSemeter?[index].scores?.count ?? 0
    }
    
    public func getNumOfPickerItem() -> Int {
        return listSemeter?.count ?? 0
    }
    
    public func getSelectedSemeterIndex() -> Int {
        return currentSemeterIndex
    }
    
    public func getSemeter(at index: Int) -> GradeRemoteData? {
        return listSemeter?[index]
    }
    
    public func getHeaderSectionData() -> TranscriptHeaderModel? {
        if let currentHeaderData = listSemeter?[currentSemeterIndex] {
            var res: TranscriptHeaderModel = .init()
            res.setHeaderData(with: currentHeaderData)
            return res
        }
        return nil
    }
    
    public func getFooterSectionData() -> TranscriptFooterModel {
        return .mockData
    }
}

// MARK: - Set
extension TranscriptViewModel {
    public func setSemeterIndex(index: Int) {
        self.currentSemeterIndex = index
    }
}


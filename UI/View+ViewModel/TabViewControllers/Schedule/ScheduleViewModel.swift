//
//  ScheduleViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 09/03/2023.
//

import Foundation

final class ScheduleViewModel {
    
    var updatePickerView: (([ScheduleRemoteData]?) -> Void)?
    
    private var listSemeter: [ScheduleRemoteData]? {
        didSet {
            updatePickerView?(listSemeter)
        }
    }
    private var currentSemeterIndex: Int = 0
}

// MARK: - Get
extension ScheduleViewModel {
    public func getListRemoteSemeter() {
        RemoteSchedule.shared.getSchedules() { [weak self] result in
            switch result {
            case .success(let listSched):
                self?.listSemeter = listSched.sorted { $0.semeterCode ?? "1" > $1.semeterCode ?? "0" }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getNumberOfSubjectInSemeter(in index: Int) -> Int {
        return listSemeter?[index].schedules?.count ?? 0
    }
    
    public func getListSubjectInSemeter(in index: Int) -> [CourseScheduleRemoteData] {
        return listSemeter?[index].schedules ?? []
    }
    
    public func getSubjectAtIndex(in semeterIndex: Int, with courseIndex: Int) -> CourseScheduleRemoteData? {
        return listSemeter?[semeterIndex].schedules?[courseIndex]
    }
    
    public func getSubjectCount(at index: Int) -> Int {
        return listSemeter?[index].schedules?.count ?? 0
    }
    
    public func getNumOfPickerItem() -> Int {
        return listSemeter?.count ?? 0
    }
    
    public func getSelectedSemeterIndex() -> Int {
        return currentSemeterIndex
    }
    
    public func getSemeter(at index: Int) -> ScheduleRemoteData? {
        return listSemeter?[index]
    }
}

// MARK: - Set
extension ScheduleViewModel {
    public func setSemeterIndex(index: Int) {
        self.currentSemeterIndex = index
    }
}

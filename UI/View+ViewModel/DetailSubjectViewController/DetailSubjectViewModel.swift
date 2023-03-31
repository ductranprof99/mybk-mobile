//
//  DetailSubjectViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 14/03/2023.
//

import Foundation

final class DetailSubjectViewModel {
    var data: CourseScheduleRemoteData
    typealias RowInput = (title: String, info: Any)
    
    private var combineData: [String:Any] {
        get {
            return ["Mã môn học": data.subjectCode ?? "--",
                    "Tiết học": "\(data.startLessonTime ?? 0) - \(data.endLessonTime ?? 0)",
                    "Thứ": "\(data.lessonDate ?? 0)",
                    "Giờ học": "\(data.timeStart ?? "--") - \(data.timeEnd ?? "--")",
                    "Mã cơ sở": data.locationCode.rawValue,
                    "Phòng": data.classRoom ?? "--",
                    "Mã nhóm": data.groupCode ?? "--",
                    "Số tín chỉ": "\(data.subjectCredit)",
                    "Số tín chỉ học phần": "\(data.semeterCredit ?? 0)",
                    "Học kỳ": data.semeterName ?? "--",
                    "Tuần học": data.weekSchedule ]
        }
    }
    
    func getData(of index: Int) -> RowInput? {
        typealias keyData = Constant.SubjectDetailView
        return combineData.count > index ? (keyData.KeyData[index], combineData[keyData.KeyData[index]] ?? "") : nil
    
    }
    
    func getSubjectName() -> String {
        return data.subjectName ?? "Unknown subject name"
    }
    
    func getSubjectType() -> String {
        return Constant.SubjectDetailView.subjectDetail
    }
    
    func getSubjectCode() -> String {
        return data.subjectCode ?? "Unknown subject code"
    }
    
    init(data: CourseScheduleRemoteData) {
        self.data = data
    }
    
    func getNumOfRow() -> Int {
        return combineData.count
    }
}

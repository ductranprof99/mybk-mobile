//
//  DetailSubjectViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 14/03/2023.
//

import Foundation

final class DetailSubjectViewModel {
    var data: SubjectModel
    typealias RowInput = (title: String, info: Any)
    func getData(of index: Int) -> RowInput? {
        let combineData:[String:Any] = ["Mã môn học": data.subjectCode,
                                        "Tiết học": data.lesson,
                                        "Thứ": data.weekDate,
                                        "Giờ học": data.hour,
                                        "Mã cơ sở": data.location,
                                        "Phòng": data.classRoom,
                                        "Mã nhóm": data.classGroup,
                                        "Số tín chỉ": data.credit,
                                        "Số tín chỉ học phần": data.creditPerSemeter,
                                        "Học kỳ": data.semeter,
                                        "Tuần học": data.schedule]
        var i = 0
        if index < 0 || index > combineData.count {
            return nil
        }
        for (key, value) in combineData {
            if i == index {
                return (title:key, info:value)
            }
        }
        return nil
    }
    
    func getSubjectName() -> String {
        return data.subjectName
    }
    
    func getSubjectType() -> String {
        return data.subjectCode 
    }
    
    init(data: SubjectModel = SubjectModel.mockData) {
        self.data = data
    }
    
    func getNumOfRow() -> Int {
        return ["Mã môn học": data.subjectCode,
                "Tiết học": data.lesson,
                "Thứ": data.weekDate,
                "Giờ học": data.hour,
                "Mã cơ sở": data.location,
                "Phòng": data.classRoom,
                "Mã nhóm": data.classGroup,
                "Số tín chỉ": data.credit,
                "Số tín chỉ học phần": data.creditPerSemeter,
                "Học kỳ": data.semeter,
                "Tuần học": data.schedule].count
    }
}

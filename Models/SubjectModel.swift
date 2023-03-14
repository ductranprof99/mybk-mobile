//
//  SubjectModel.swift
//  MybkMobile
//
//  Created by DucTran on 14/03/2023.
//

import Foundation

struct SubjectModel: Codable {
    var subjectType: String? = "Môn học"
    var subjectName: String
    var subjectCode: String
    var lesson: String
    var weekDate: String
    var hour: String
    var location: String
    var classRoom: String
    var classGroup: String
    var credit: String
    var creditPerSemeter: String
    var semeter: String
    var schedule: [String]
    
    static var mockData = SubjectModel(subjectName: "Đề cương luận văn tốt nghiệp (Khoa học Máy tính)",
                                       subjectCode: "CO4317",
                                       lesson: "13 - 15",
                                       weekDate: "3",
                                       hour: "16:00 - 18:50",
                                       location: "BK-CS1",
                                       classRoom: "401H1",
                                       classGroup: "L01",
                                       credit: "9",
                                       creditPerSemeter: "9.5",
                                       semeter: "Học kỳ 2 | 2021 - 2022",
                                       schedule: ["36","37","38","39","40","41","42","43","44"])
}

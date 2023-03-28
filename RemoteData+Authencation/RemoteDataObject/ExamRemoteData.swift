//
//  SemeterExamModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

struct ExamRemoteData: Codable {
    
    var semeterName, semeterCode, updateDate: String?
    var semeterState: String?
    var exams: [CourseExamRemoteData]?
    
    enum CodingKeys: String, CodingKey {
        case exams = "lichthi"
        case updateDate = "ngay_cap_nhat"
        case semeterName = "ten_hocky"
        case semeterCode = "hk_nh"
        case semeterState = "trang_thai"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let array = try? container.decodeIfPresent([CourseExamRemoteData].self, forKey: .exams) {
            exams = array
        } else if let dict = try? container.decodeIfPresent([String: CourseExamRemoteData].self, forKey: .exams) {
            exams = dict.map { $0.value }
        } else {
            exams = nil
        }
        
        updateDate = try container.decodeIfPresent(String.self, forKey: .updateDate)
        semeterName = try container.decodeIfPresent(String.self, forKey: .semeterName)
        semeterCode = try container.decodeIfPresent(String.self, forKey: .semeterCode)
        semeterState = try container.decodeIfPresent(String.self, forKey: .semeterState)
    }
}


struct CourseExamRemoteData: Codable {
    var midTermExamTime: String?
    var endTermExamTime: String?
    var subjectCode: String?
    var midTermExamDate: String?
    var endTermExamDate: String?
    var subGroup: String? 
    var midTermExamLocation: String?
    var endTermExamLocation: String?
    var subjectName: String?
    
    enum CodingKeys: String, CodingKey {
        case midTermExamTime = "gio_kt"
        case endTermExamTime = "gio_thi"
        case subjectCode = "ma_mh"
        case midTermExamDate = "ngaykt"
        case endTermExamDate = "ngaythi"
        case subGroup = "nhomto"
        case midTermExamLocation = "phong_ktra"
        case endTermExamLocation = "phong_thi"
        case subjectName = "ten_mh"
    }
    
}

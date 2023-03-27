//
//  CourseScheduleDataObject.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData
struct CourseScheduleDataObject: Codable {
    var timeStart: String?
    var timeEnd: String?
    var personalStartSemeter: String?
    var subjectCode: String?
    var groupCode: String?
    var locationCode: String?
    var subGroup: String?
    var classRoom: String?
    var subjectCredit: String?
    var semeterCredit: Float?
    var semeterName: String?
    var subjectName: String?
    var lessonDate: String?
    var startLessonTime: String?
    var endLessonTime: String?
    var courseTime: String?
    
    enum CodingKeys: String, CodingKey {
        case timeStart = "giobd"
        case timeEnd = "giokt"
        case personalStartSemeter = "hk_nh"
        case subjectCode = "ma_mh"
        case groupCode = "ma_nhom"
        case locationCode = "macoso"
        case subGroup = "nhomto"
        case classRoom = "phong1"
        case subjectCredit = "so_tin_chi"
        case semeterCredit = "tc_hp"
        case semeterName = "ten_hocky"
        case subjectName = "ten_mh"
        case lessonDate = "thu1"
        case startLessonTime = "tiet_bd1"
        case endLessonTime = "tiet_kt1"
        case courseTime = "tuan_hoc"
    }
    
}

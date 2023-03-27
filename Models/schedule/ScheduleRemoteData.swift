//
//  ScheduleRemoteData.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation

struct ScheduleRemoteData: Codable {
    var schedules: [CourseScheduleRemoteData]?
    var semeterName, semeterCode, updateDate: String?

    enum CodingKeys: String, CodingKey {
        case schedules = "tkb"
        case semeterName = "ten_hocky"
        case semeterCode = "hk_nh"
        case updateDate = "ngay_cap_nhat"
    }
}

struct CourseScheduleRemoteData: Codable {
    var subjectCode, subjectName, subGroup, courseTime: String?
    var locationCode: Macoso
    var lessonDate, startLessonTime, endLessonTime: Int?
    var classRoom: String?
    var semeterCredit: Double?
    var subjectCredit: Int
    var groupCode, studentCode, studentStartSemeter, semeterName: String?
    var timeStart, timeEnd: String?
    
    var weekSchedule: [String] {
        if let courseTime = courseTime {
            return courseTime.split(separator: "|").map { String($0) }
        }
        return []
    }
    
    enum CodingKeys: String, CodingKey {
        case timeStart = "giobd"
        case timeEnd = "giokt"
        case studentStartSemeter = "hk_nh"
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
        case studentCode = "mssv"
    }
    
}

enum Macoso: String, Codable {
    case bk = "BK"
    case bkCs1 = "BK-CS1"
    case bkCs2 = "BK-CS2"
}

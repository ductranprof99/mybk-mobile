//
//  GradeRemoteData.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class GradeRemoteData: Codable {
    var scores: [CourseGradeRemoteData]?
    var actionScore: String?
    var avgSemeterScore: String?
    var avgTotalScore: String?
    var scholashipCondition: String?
    var avgScoreExtend: String?
    var scholarshipResult: String?
    var updateDate: String?
    var scholarsipDate: String?
    var numOfRegisteredCreditInSemeter: String?
    var numOfTotalPassCredit: String?
    var numOfPassCreditInSemeter: String?
    var semeterName: String?
    var semeterCode: String?
    var scholarshipPrize: String?
    
    enum CodingKeys: String, CodingKey {
        case scores = "diem"
        case actionScore = "diem_renluyen"
        case avgSemeterScore = "diem_tb"
        case avgTotalScore = "diem_tbtl"
        case scholashipCondition = "dieukien_hbkk"
        case avgScoreExtend = "dtb_chung_morong"
        case scholarshipResult = "kq_hbkk"
        case updateDate = "ngay_cap_nhat"
        case scholarsipDate = "ngay_hbkk"
        case numOfRegisteredCreditInSemeter = "so_tc"
        case numOfTotalPassCredit = "so_tctl"
        case numOfPassCreditInSemeter = "so_tctl_hk"
        case semeterName = "ten_hocky"
        case semeterCode = "hk_nh"
        case scholarshipPrize = "sotien_hbkk"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let array = try? container.decodeIfPresent([CourseGradeRemoteData].self, forKey: .scores) {
            scores = array
        } else if let dict = try? container.decodeIfPresent([String: CourseGradeRemoteData].self, forKey: .scores) {
            scores = dict.map { $0.value }
        } else {
            scores = nil
        }
        
        updateDate = try? container.decodeIfPresent(String.self, forKey: .updateDate)
        semeterName = try? container.decodeIfPresent(String.self, forKey: .semeterName)
        semeterCode = try? container.decodeIfPresent(String.self, forKey: .semeterCode)
        actionScore = try? container.decodeIfPresent(String.self, forKey: .actionScore)
        avgTotalScore = try? container.decodeIfPresent(String.self, forKey: .avgTotalScore)
        scholashipCondition = try? container.decodeIfPresent(String.self, forKey: .scholashipCondition)
        avgSemeterScore = try? container.decodeIfPresent(String.self, forKey: .avgSemeterScore)
        avgScoreExtend = try? container.decodeIfPresent(String.self, forKey: .avgScoreExtend)
        scholarshipResult = try? container.decodeIfPresent(String.self, forKey: .scholarshipResult)
        scholarsipDate = try? container.decodeIfPresent(String.self, forKey: .scholarsipDate)
        numOfRegisteredCreditInSemeter = try? container.decodeIfPresent(String.self, forKey: .numOfRegisteredCreditInSemeter)
        numOfTotalPassCredit = try? container.decodeIfPresent(String.self, forKey: .numOfTotalPassCredit)
        numOfPassCreditInSemeter = try? container.decodeIfPresent(String.self, forKey: .numOfPassCreditInSemeter)
        scholarshipPrize = try? container.decodeIfPresent(String.self, forKey: .scholarshipPrize)
    }
}


final class CourseGradeRemoteData: Codable {
    var subScore: String?
    var examScore: String?
    var finalScore: String?
    var subjectCode: String?
    var subGroup: String?
    var subjectCredit: String?
    var subjectName: String?
    
    enum CodingKeys: String, CodingKey {
        case subScore = "diem_thanhphan"
        case examScore = "diem_thi"
        case finalScore = "diem_tong_ket"
        case subjectCode = "ma_mh"
        case subGroup = "nhomto"
        case subjectCredit = "so_tin_chi"
        case subjectName = "ten_mh"
    }
    
}

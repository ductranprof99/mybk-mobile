//
//  ProfileRemoteData.swift
//  MybkMobile
//
//  Created by DucTran on 01/04/2023.
//

import Foundation

struct ProfileRemoteData: Codable {
    let studentDetail: StudentDetail?
    let sex: String?
    let BoD: String?
    let className: String?
    let programType : String?
    let email: String?
    let majorCode : String?
    let majorName : String?
    let status: String?
    let studentAvatar: String?
    let citizenId: String?
    let enrollmentDate: String?
    let graduateDate: String?
    let minorMajorCode: String?
    let minorMajorName: String?
    let homeRoomTeacher: String?

    enum CodingKeys: String, CodingKey {
        case studentDetail = "chitiet"
        case sex = "phai"
        case BoD = "ngay_sinh"
        case className = "tenlop_cn"
        case programType = "he_daotao"
        case email
        case majorCode = "ma_khoa"
        case majorName = "ten_khoa"
        case status = "tinh_trang"
        case studentAvatar = "hinh_sinhvien"
        case citizenId = "so_cmnd"
        case enrollmentDate = "thoigian_vao"
        case graduateDate = "thoigian_ra"
        case minorMajorCode = "ma_nganh"
        case minorMajorName = "ten_nganh_daotao"
        case homeRoomTeacher = "gvcn_hoten"
    }
}

// MARK: - Chitiet
struct StudentDetail: Codable {
    let id, name, idnumber: String?

    enum CodingKeys: String, CodingKey {
        case id, name, idnumber
    }
}

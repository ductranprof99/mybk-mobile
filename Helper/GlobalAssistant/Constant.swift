//
//  Constant.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation

struct Constant {
    struct Network {
        static let SSO_MYBK_REDIRECT_URL =
        "https://sso.hcmut.edu.vn/cas/login?service=http%3A%2F%2Fmybk.hcmut.edu.vn%2Fstinfo%2F"
        static let SSO_URL =
        "https://sso.hcmut.edu.vn/cas/login"
        static let HTML_LOGIN_SUCCESS = "<h2>Log In Successful</h2>"
        static let HTML_WRONG_CREDENTIAL =
        "The credentials you provided cannot be determined to be authentic"
        static let STINFO_URL =
        "https://mybk.hcmut.edu.vn/stinfo/"
        static let SSO_MYBK_LOGOUT_URL = "https://sso.hcmut.edu.vn/cas/logout"
        
        static let MYBK_SCHEDULE = "https://mybk.hcmut.edu.vn/stinfo/lichthi/ajax_lichhoc"
        static let MYBK_GRADE = "https://mybk.hcmut.edu.vn/stinfo/grade/ajax_grade"
        static let MYBK_EXAM = "https://mybk.hcmut.edu.vn/stinfo/lichthi/ajax_lichthi"
    }
    
    struct Key {
        static let mybkToken = "key.mybkToken"
        static let bioMetric = "key.bioInfomation"
    }
    
    
    struct LearnScheduleView {
        static let all = "Tất cả"
    }
    
    struct SubjectDetailView {
        static let KeyData: [String] = ["Mã môn học",
                                         "Tiết học",
                                         "Thứ",
                                         "Giờ học",
                                         "Mã cơ sở",
                                         "Phòng",
                                         "Mã nhóm",
                                         "Số tín chỉ",
                                         "Số tín chỉ học phần",
                                         "Học kỳ",
                                         "Tuần học"]
        
        static let subjectDetail = "Môn học"
    }
    
    
    struct GradeHeader {
        static let summarizeTitle = "Tổng kết"
        static let scholarshipTitle = "Thông tin xét học bổng khuyến khích"
        
        enum SummarizeTitle: String {
            case numOfRegCredit = "Số tín chỉ đăng ký học kỳ"
            case numOfPassCreditSemeter = "Số tín chỉ tích lũy học kỳ"
            case numOfTotalPassCredit = "Số tín chỉ tích lũy"
            case avgSemeterScore = "Điểm trung bình học kỳ"
            case avgTotalScore = "Điểm trung bình tích lũy"
        }
        
        enum ScholarshipTitle: String {
            case avgSemeterScore = "ĐTB 1 học kỳ"
            case actionScore = "Điểm rèn luyện"
            case numOfPassCreditSemeter = "Số TC đạt trong học kỳ"
            case numOfTotalPassCredit = "Số TC tích lũy"
            case scholarshipCondition = "Điều kiện xét HBKK"
            case scholarshipResult = "Kết quả xét HBKK"
            case updateDate = "Ngày cập nhật"
        }
    }
    
    struct GradeFooter {
        static let sectionTitle: String = "Các điểm đặc biệt"
        
        static let detail: [(title: String, detail: String, point: String)] =  [("Cấm thi", "Được tính như điểm 0", "11 CT"),
                                  ("Miễn học, miễn thi", "Đạt nhưng không tính vào ĐTB", "12 MT"),
                                  ("Vắng thi", "Được tính như điểm 0", "13 VT"),
                                  ("Hoãn thi, được phép thi sau", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước","14 HT"),
                                  ("Chưa có điểm", "Chưa tính số TCTL và ĐTB", "15 CH"),
                                  ("Rút môn học", "Không ghi vào bảng điểm", "17 RT"),
                                  ("Không đạt", "Được tính như điểm 0", "20 KD"),
                                  ("Đạt", "Đạt nhưng không tính vào ĐTB", "21 DT"),
                                  ("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP")]
    }
    
    struct MainTabView {
        static let popUpSeletectButtonTitle = "Chọn học kì"
    }
    
    struct ProfileView {
        static let githubLink = "https://github.com/ductranprof99/mybk-mobile"
        
        static let recipentEmail = "maillungtung@gmail.com"
        static let emalSubject = "Notice about ios Version myBK error"
        static let emailBody = "I want to inform you some information about some error happenned in iOS version of myBK"
        
    }
}

enum SSOState: String, Error {
    case UNAUTHORIZED
    case NO_CREDENTIALS
    case LOGGED_IN
    case WRONG_PASSWORD
    case TOO_MANY_TRIES
    case UNKNOWN
    case NETWORKERROR
    
    func asLoginStatus() -> LoginStatus {
        switch self {
        case .UNAUTHORIZED:
            return .WrongCredential
        case .NO_CREDENTIALS:
            return .NoCredential
        case .LOGGED_IN:
            return .SSOAck
        case .WRONG_PASSWORD:
            return .WrongCredential
        case .TOO_MANY_TRIES:
            return .TooManyTries
        case .UNKNOWN:
            return .Unknown
        case .NETWORKERROR:
            return .NetworkError
        }
    }
}

enum MybkState {
    case LOGGED_IN
    case SSO_REQUIRED
    case UNKNOWN
    
    func asLoginStatus() -> LoginStatus {
        switch self {
        case .LOGGED_IN:
            return .Successful
        default:
            return .Failed
        }
    }
}

enum LoginStatus {
    case TooManyTries
    case WrongCredential
    case NoCredential
    case NetworkError
    case Unknown
    case SSOAck
    
    
    case Failed
    case Successful
}



//
//  TranscriptAdditionalModel.swift
//  MybkMobile
//
//  Created by DucTran on 11/03/2023.
//

import Foundation

enum HeaderSectionType: Int {
    case summarize = 0
    case scholarship
}
enum HeaderSectionData {
    case summarize(info: [(title: String, detail: String)]?)
    case scholarship(info: [(title: String, detail: String)]?)
}

struct TranscriptHeaderModel {
    
    private var summarizeData: [(title: String, detail: String)]?
    
    private var scholarshipData: [(title: String, detail: String)]?
    
    func numOfSection() -> Int {
        return 2
    }
    
    func getSectionData(section: HeaderSectionType) -> HeaderSectionData {
        switch section {
        case .summarize:
            return .summarize(info: self.summarizeData)
        case .scholarship:
            return .scholarship(info: self.scholarshipData)
        }
    }
    
    func getSectionTitle(section: HeaderSectionType) -> String {
        switch section {
        case .summarize:
            return "Tổng kết"
        case .scholarship:
            return "Thông tin xét học bổng khuyến khích"
        }
    }
    
    mutating func setHeaderData(with headerData: GradeRemoteData) {
        self.summarizeData = [("Số tín chỉ đăng ký học kỳ", headerData.numOfRegisteredCreditInSemeter ?? "--"),
                              ("Số tín chỉ tích lũy học kỳ", headerData.numOfPassCreditInSemeter ?? "--"),
                              ("Điểm trung bình học kỳ", headerData.avgSemeterScore ?? "--"),
                              ("Số tín chỉ tích lũy", headerData.numOfTotalPassCredit ?? "--"),
                              ("Điểm trung bình tích lũy", headerData.avgTotalScore ?? "--")]
        
        self.scholarshipData = [("ĐTB 1 học kỳ", headerData.avgSemeterScore ?? "--"),
                                ("Điểm rèn luyện", headerData.actionScore ?? "--"),
                                ("Số TC đạt trong học kỳ", headerData.numOfPassCreditInSemeter ?? "--"),
                                ("Số TC tích lũy", headerData.numOfTotalPassCredit ?? "--"),
                                ("Điều kiện xét HBKK", headerData.scholashipCondition ?? "--"),
                                ("Kết quả xét HBKK", headerData.scholarshipResult ?? "--"),
                                ("Ngày cập nhật", headerData.scholarsipDate  ?? "--")]
    }
}

struct TranscriptFooterModel {
    typealias RowData = (title: String, detail: String, point: String)
    var sectionTitle: String
    var detail: [RowData]
    
    func numOfSection() -> Int {
        return 1
    }
    
    func getSectionData(in index: Int) -> RowData? {
        if index < detail.count, index > -1 {
            return detail[index]
        }
        return nil
    }
    
    func getTitle() -> String {
        return sectionTitle
    }
    
    func numOfRow() -> Int {
        return detail.count
    }
    
    static var mockData: TranscriptFooterModel = .init(sectionTitle: "Các điểm đặc biệt",
                                                      detail: [("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP"),
                                                               ("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP"),
                                                               ("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP"),
                                                               ("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP"),
                                                               ("Vắng thi có phép", "Không đạt và không tính vào ĐTB Được thỏa điều kiện môn học trước", "22 VP")])
}

//
//  TranscriptAdditionalModel.swift
//  MybkMobile
//
//  Created by DucTran on 11/03/2023.
//

import Foundation

struct ListInfoModel {
    typealias RowData = (title: String, detail: String?, crucial: String?)
    var title: String
    var detail: [RowData]
    
    func numOfRow() -> Int {
        return detail.count
    }
    
    func dataOfRow(in row: Int) -> RowData? {
        if row < detail.count {
            return detail[row]
        }
        return nil
    }
    
    static let mockDataNoDetail = ListInfoModel(title: "Tong ket",
                                        detail: [("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16"),
                                                 ("So tin chi dang ki", nil, "16")])
    
    static let mockDataDetail = ListInfoModel(title: "Tong ket",
                                        detail: [("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil),
                                                 ("So tin chi dang ki", "16", nil)])
}


struct TranscriptHeaderModel {
    
    var sectionsData: [ListInfoModel] = [.mockDataNoDetail, .mockDataNoDetail]
    
    func numOfSection() -> Int {
        return sectionsData.count
    }
    
    func getSectionData(section: Int) -> ListInfoModel? {
        if section < sectionsData.count {
            return sectionsData[section]
        }
        return nil
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

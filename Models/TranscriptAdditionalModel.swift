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
}

struct TranscriptHeaderModel {
    
    var sectionsData: [ListInfoModel] = [.init(title: "Tong ket", detail: [("So tin chi dang ki", nil, "16")])]
    
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
    
    var sectionsData: ListInfoModel = .init(title: "Tong ket", detail: [("So tin chi dang ki", nil, "16")])
    
    func numOfSection() -> Int {
        return 1
    }
    
    func getSectionData() -> ListInfoModel {
        return sectionsData
    }
}

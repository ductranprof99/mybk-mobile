//
//  GradeFooterViewModel.swift
//  MybkMobile
//
//  Created by DucTran on 31/03/2023.
//

import Foundation

struct TranscriptFooterModel {
    
    func numOfSection() -> Int {
        return 1
    }
    
    func getSectionData(in index: Int) -> (title: String, detail: String, point: String)? {
        if index < Constant.GradeFooter.detail.count, index > -1 {
            return Constant.GradeFooter.detail[index]
        }
        return nil
    }
    
    func getTitle() -> String {
        return Constant.GradeFooter.sectionTitle
    }
    
    func numOfRow() -> Int {
        return Constant.GradeFooter.detail.count
    }
}

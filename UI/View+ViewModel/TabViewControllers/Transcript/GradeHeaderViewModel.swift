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
            return Constant.GradeHeader.summarizeTitle
        case .scholarship:
            return Constant.GradeHeader.scholarshipTitle
        }
    }
    
    mutating func setHeaderData(with headerData: GradeRemoteData) {
        typealias scoreTitle = Constant.GradeHeader.SummarizeTitle
        typealias scholarTitle = Constant.GradeHeader.ScholarshipTitle
        self.summarizeData = [(scoreTitle.numOfRegCredit.rawValue, headerData.numOfRegisteredCreditInSemeter ?? "--"),
                              (scoreTitle.numOfPassCreditSemeter.rawValue, headerData.numOfPassCreditInSemeter ?? "--"),
                              (scoreTitle.numOfTotalPassCredit.rawValue, headerData.numOfTotalPassCredit ?? "--"),
                              (scoreTitle.avgSemeterScore.rawValue, headerData.avgSemeterScore ?? "--"),
                              (scoreTitle.avgTotalScore.rawValue, headerData.avgTotalScore ?? "--")]
        
        self.scholarshipData = [(scholarTitle.avgSemeterScore.rawValue, headerData.avgSemeterScore ?? "--"),
                                (scholarTitle.actionScore.rawValue, headerData.actionScore ?? "--"),
                                (scholarTitle.numOfPassCreditSemeter.rawValue, headerData.numOfPassCreditInSemeter ?? "--"),
                                (scholarTitle.numOfTotalPassCredit.rawValue, headerData.numOfTotalPassCredit ?? "--"),
                                (scholarTitle.scholarshipCondition.rawValue, headerData.scholashipCondition ?? "--"),
                                (scholarTitle.scholarshipResult.rawValue, headerData.scholarshipResult ?? "--"),
                                (scholarTitle.updateDate.rawValue, headerData.scholarsipDate  ?? "--")]
    }
}


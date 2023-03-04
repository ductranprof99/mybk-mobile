//
//  SubjectCellModel.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation

struct TestInfo {
    var location: String
    var time: String
    var date: String
}

struct SubjectCellModel {
    var weekDay = "Thu 2"
    var hours = "16:00 - 18 - 50"
    var location = "HANGOUT_TUONGTAC"
    var activeWeek: [Int] = [1,2,3,4,5,6,7]
    
    var midTermTestInfo: TestInfo = .init(location: "6969", time: "16:00", date: "6/9")
    var endTermTestInfo: TestInfo = .init(location: "6969", time: "16:00", date: "6/9")
    
    var midTermScore: String = "5.0"
    var subScore: [String: String] = [:]
    var finalTermScore: String = "5.0"
    var finalScore: String = "N/A"
    
    var periodScore: String {
        get {
            var res = "KT:" + midTermScore
            for i in subScore {
                res += "\(i.key) : \(i.value)"
            }
            return res
        }
    }
}

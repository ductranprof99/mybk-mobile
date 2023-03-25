//
//  SubjectCellModel.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import CoreData

enum SubjectCellModelType {
    case schedule
    case test
    case score
}

struct TestInfo {
    var location: String
    var time: String
    var date: String
}

struct SubjectCellModel {
    
    var dataType: SubjectCellModelType = .schedule
    
    // MARK: - top view cell
    var subjectName: String = "LUAN VAN TOT NGHIEP(KHMT)"
    var subjectCode: String = "CO4317"
    var classRoomCode: String = "L01"
    var credit: String = "9 tin chi"
    
    // MARK: - bottom view cell data
    // sched bottom
    var weekDay: String = "Thu 2"
    var hours: String = "16:00 - 18:50"
    var location: String = "HANGOUT_TUONGTAC"
    var activeWeek: [Int] = [1,2,3,4,5,6,7]
    
    // test bottom
    var midTermTestInfo: TestInfo = .init(location: "6969", time: "16:00", date: "6/9")
    var endTermTestInfo: TestInfo = .init(location: "6969", time: "16:00", date: "6/9")
    
    // score bottom
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

//final class SubjectDataObject: NSManagedObject, Decodable {
//    @NSManaged var subjectName: String
//    @NSManaged var subjectCode: String
//    @NSManaged var classRoomCode: String
//    @NSManaged var credit: String
//    @NSManaged var weekDay: String
//    @NSManaged var hours: String
//    @NSManaged var location: String
//    @NSManaged var activeWeek: [Int]
//    @NSManaged var midTermTestInfo: TestInfo
//    @NSManaged var endTermTestInfo: TestInfo
//    @NSManaged var midTermScore: String
//    @NSManaged var subScore: [String: String]
//    @NSManaged var finalTermScore: String
//    @NSManaged var finalScore: String
//    
//    
//    enum CodingKeys: CodingKey {
//       
//    }
//    required convenience public init(from decoder: Decoder) {
//        self.init()
//    }
//}

//
//  CourseGradeModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class CourseGrade: NSManagedObject, Decodable {
    var diem_thanhphan: String?
    var diem_thi: String?
    var diem_tong_ket: String?
    var ma_mh: String?
    var nhomto: String?
    var so_tin_chi: Int?
    var ten_mh: String?
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

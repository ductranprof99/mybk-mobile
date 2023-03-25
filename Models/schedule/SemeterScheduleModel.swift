//
//  SemeterScheduleModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class SemeterScheduleModel: NSManagedObject, Decodable {
    var hk_nh: String?
    var ngay_cap_nhat: String?
    var ten_hocky: String?
    var tkb: [CourseScheduleModel]?
    
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

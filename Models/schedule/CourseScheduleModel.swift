//
//  CourseSceduleModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class CourseScheduleModel: NSManagedObject, Decodable {
    var giobd: String?
    var giokt: String?
    var hk_nh: String?
    var ma_mh: String?
    var ma_nhom: String?
    var macoso: String?
    var nhomto: String?
    var phong1: String?
    var so_tin_chi: Int?
    var tc_hp: Float?
    var ten_hocky: String?
    var ten_mh: String?
    var thu1: String?
    var tiet_bd1: Int?
    var tiet_kt1: Int?
    var tuan_hoc: String?
    
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

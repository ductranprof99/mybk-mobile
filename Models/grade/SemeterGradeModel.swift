//
//  SemeterGradeModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class SemeterGradeModel: NSManagedObject, Decodable {
    var diem: [CourseGrade]?
    var diem_renluyen: String?
    var diem_tb: String?
    var diem_tbtl: String?
    var dieukien_hbkk: String?
    var dtb_1hocky: String?
    var dtb_chung_morong: String?
    var kq_hbkk: String?
    var ngay_cap_nhat: String?
    var ngay_hbkk: String?
    var so_tc: String?
    var so_tctl: String?
    var so_tctl_hk: String?
    var sotc_dat_hocky: String?
    var ten_hocky: String?
    
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

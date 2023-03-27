//
//  SemeterExamModel.swift
//  MybkMobile
//
//  Created by DucTran on 24/03/2023.
//

import Foundation
import CoreData

final class SemeterExamModel: NSManagedObject, Decodable {
    
    var ngay_cap_nhat: String?
    var ten_hocky: String?
    var lichthi: Array<CourseExamModel>?
    
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

final class CourseExamModel: NSManagedObject, Decodable {
    var gio_kt: String?
    var gio_thi: String?
    var ma_mh: String?
    var ngaykt: String?
    var ngaythi: String?
    var nhomto: String?
    var phong_ktra: String?
    var phong_thi: String?
    var ten_mh: String?
    
    required convenience public init(from decoder: Decoder) {
        self.init()
        
        // additional setup here
    }
    
    enum CodingKeys: CodingKey {
        
    }
    
}

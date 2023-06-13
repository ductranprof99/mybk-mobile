//
//  ScheduleSemeterLocalData+CoreDataClass.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//
//

import Foundation
import CoreData


public class ScheduleSemeterLocalData: NSManagedObject {
    static func isExist(scheduleSemeter: ScheduleRemoteData) -> Bool {
        // find object if existing in db
        return true
    }
    
    static func isNeedUpdate(scheduleSemeter: ScheduleRemoteData) -> Bool {
        // find object in db
        return true
    }
}

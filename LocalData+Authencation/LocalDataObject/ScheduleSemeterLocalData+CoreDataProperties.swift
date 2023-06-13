//
//  ScheduleSemeterLocalData+CoreDataProperties.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//
//

import Foundation
import CoreData


extension ScheduleSemeterLocalData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleSemeterLocalData> {
        return NSFetchRequest<ScheduleSemeterLocalData>(entityName: "ScheduleSemeterLocalData")
    }
    
    @NSManaged public var semeterCode: String?
    @NSManaged public var semeterName: String?
    @NSManaged public var updateDate: String?
    @NSManaged public var schedules: NSSet?
    
    public var wrappedSemeterCode: String {
        return semeterCode ?? "unknown semeter code"
    }
    
    public var wrappedSemeterName: String {
        return semeterName ?? "unknown semeter code"
    }
    
    public var wrappedUPdateDate: String {
        return updateDate ?? "unknown semeter code"
    }
    
    public var schedulesArray: [ScheduleLocalData] {
        let set = schedules as? Set<ScheduleLocalData> ?? []
        
        return set.sorted(by: { $0.lessonDate < $1.lessonDate })
    }
}

// MARK: Generated accessors for schedules
extension ScheduleSemeterLocalData {

    @objc(addSchedulesObject:)
    @NSManaged public func addToSchedules(_ value: ScheduleLocalData)

    @objc(removeSchedulesObject:)
    @NSManaged public func removeFromSchedules(_ value: ScheduleLocalData)

    @objc(addSchedules:)
    @NSManaged public func addToSchedules(_ values: NSSet)

    @objc(removeSchedules:)
    @NSManaged public func removeFromSchedules(_ values: NSSet)

}

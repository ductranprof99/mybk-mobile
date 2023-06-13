//
//  ScheduleLocalData+CoreDataProperties.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//
//

import Foundation
import CoreData


extension ScheduleLocalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleLocalData> {
        return NSFetchRequest<ScheduleLocalData>(entityName: "ScheduleLocalData")
    }

    @NSManaged public var classRoom: String?
    @NSManaged public var courseTime: String?
    @NSManaged public var endLessonTime: Int32
    @NSManaged public var groupCode: String?
    @NSManaged public var lessonDate: Int32
    @NSManaged public var semeterCredit: Double
    @NSManaged public var semeterName: String?
    @NSManaged public var startLessonTime: Int32
    @NSManaged public var startSemeter: String?
    @NSManaged public var studentCode: String?
    @NSManaged public var subGroup: String?
    @NSManaged public var subjectCode: String?
    @NSManaged public var subjectCredit: Int16
    @NSManaged public var subjectName: String?
    @NSManaged public var timeEnd: String?
    @NSManaged public var timeStart: String?
    @NSManaged public var location: LocationCodeLocalData?
    @NSManaged public var scheduleSemeter: ScheduleSemeterLocalData?

}

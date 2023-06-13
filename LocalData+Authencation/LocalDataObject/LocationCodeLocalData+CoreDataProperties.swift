//
//  LocationCodeLocalData+CoreDataProperties.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//
//

import Foundation
import CoreData


extension LocationCodeLocalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCodeLocalData> {
        return NSFetchRequest<LocationCodeLocalData>(entityName: "LocationCodeLocalData")
    }

    @NSManaged public var name: String?
    @NSManaged public var schedule: ScheduleLocalData?

}

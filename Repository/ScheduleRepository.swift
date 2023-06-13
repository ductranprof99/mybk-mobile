//
//  ScheduleRepository.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//

import UIKit
import CoreData

final class ScheduleRepository: NSObject, RepositoryInterface {
//    var listSemeter: [ScheduleRemoteData] = []
    
    var fetchedResultsController: NSFetchedResultsController<ScheduleSemeterLocalData>!
    
    func updateFromRemote(completion: @escaping (UpdateState) -> Void) {
        RemoteSchedule.shared.getSchedules() { [weak self] result in
            switch result {
            case .success(let listSched):
                let listSemeter = listSched.sorted { $0.semeterCode ?? "1" > $1.semeterCode ?? "0" }
                self?.saveToCoreData(with: listSemeter)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func syncToLocal() {
    }
    
    override init() {
        let fetchRequest: NSFetchRequest<ScheduleSemeterLocalData> = ScheduleSemeterLocalData.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: "semeterCode", ascending: false)]
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let manageContext = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: manageContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        }
        super.init()
        if fetchedResultsController != nil {
            print("fetched result instance initialization successful: Schedule Repository")
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("fetched result cannot perform fetch: Schedule Repository")
            }
        }
    }
    
    func getFromLocal() {
        
        
    }
    
    func saveToCoreData(with data: [ScheduleRemoteData]) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let manageContext = appDelegate.persistentContainer.viewContext
            for scheduleData in data {
                do {
                    try insertToLocal(context: manageContext, remoteData: scheduleData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func insertToLocal(context: NSManagedObjectContext, remoteData: ScheduleRemoteData) throws {
        let localSchedSemeter = ScheduleSemeterLocalData(context: context)
        localSchedSemeter.semeterCode = remoteData.semeterCode
        localSchedSemeter.semeterName = remoteData.semeterName
        localSchedSemeter.updateDate = remoteData.updateDate
        guard let listSchedule = remoteData.schedules else {
            return
        }
        var inv: [ScheduleLocalData] = []
        for schedule in listSchedule {
            let localSched = ScheduleLocalData(context: context)
            localSched.scheduleSemeter = localSchedSemeter
            localSched.semeterName = schedule.semeterName
            localSched.lessonDate = Int32(schedule.lessonDate ?? 0)
            localSched.timeEnd = schedule.timeEnd
            localSched.timeStart = schedule.timeStart
            localSched.classRoom = schedule.classRoom
            localSched.courseTime = schedule.courseTime
            localSched.endLessonTime = Int32(schedule.endLessonTime ?? 0)
            localSched.startLessonTime = Int32(schedule.startLessonTime ?? 0)
            localSched.groupCode = schedule.groupCode
            localSched.location = LocationCodeLocalData(context: context)
            localSched.location?.name = schedule.locationCode.rawValue
            localSched.semeterCredit = schedule.semeterCredit ?? 0
            localSched.studentCode = schedule.studentCode
            localSched.subGroup = schedule.subGroup
            localSched.subjectName = schedule.subjectName
            localSched.subjectCode = schedule.subjectCode
            localSched.subjectCredit = Int16(schedule.subjectCredit)
            inv.append(localSched)
        }
        try context.save()
    }
    
    private func insertToLocalLegacy(context: NSManagedObjectContext, remoteData: ScheduleRemoteData) throws {
        let entity = NSEntityDescription.entity(forEntityName: "ScheduleSemeterLocalData", in: context)!
        let scheduleSemeter = NSManagedObject(entity: entity, insertInto: context)
        scheduleSemeter.setValue(remoteData.semeterCode, forKey: "semeterCode")
        scheduleSemeter.setValue(remoteData.semeterName, forKey: "semeterName")
        scheduleSemeter.setValue(remoteData.updateDate, forKey: "updateDate")
//        guard let listSchedule = remoteData.schedules else {
//            return
//        }
//        for schedule in listSchedule {
//        }
        try context.save()
    }
}

extension ScheduleRepository: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            print("insert")
        case .delete:
            print("delete")
        case .move:
            print("move")
        case .update:
            print("update")
        default:
            print("default")
        }
    }
    
}

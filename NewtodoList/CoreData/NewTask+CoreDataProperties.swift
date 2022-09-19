//
//  NewTask+CoreDataProperties.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/23.
//
//

import Foundation
import CoreData


extension NewTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewTask> {
        
        return NSFetchRequest<NewTask>(entityName: "NewTask")
    }

    @NSManaged public var task: String?
    @NSManaged public var done: Bool
    @NSManaged public var isArchived:Bool
    @NSManaged public var isOverdue:Bool
    @NSManaged public var taskDescription:String?
    @NSManaged public var date:Date?
    @NSManaged public var category:String?
}

extension NewTask : Identifiable {

}

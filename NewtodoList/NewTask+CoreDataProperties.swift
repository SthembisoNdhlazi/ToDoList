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

}

extension NewTask : Identifiable {

}

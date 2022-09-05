//
//  DataProvider.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/09/01.
//

import Foundation
import UIKit
import CoreData

class DataProvider{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [NewTask]()
    
    func getAllItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        
        request.predicate = NSPredicate(format: "isArchived == 0")
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        request.sortDescriptors = [doneSort]
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    func getArchivedItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        
        request.predicate = NSPredicate(format: "isArchived == 1")
        
        
        
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    func createItem(task:String){
        let newItem = NewTask(context: context)
        newItem.task = task
        newItem.done = false
        newItem.isArchived = false
        do{
            try context.save()
            getAllItems()
            
        }catch{
          print("error saving")
        }
        print(newItem.done)
    }
    
    func deleteItem(item:NewTask){
        context.delete(item)
        
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func updateItem(item:NewTask, newTaskName:String, description:String, date:Date?){
        item.task = newTaskName
        item.taskDescription = description
        item.date = date
        do{
            try context.save()
        }catch{
            
        }
    }
    
}

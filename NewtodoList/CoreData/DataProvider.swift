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
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    
    func getUrgentItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
        let archivePredicate = NSPredicate(format: "isArchived == 0")
        let urgentPredicate = NSPredicate(format: "category == 'Urgent'")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [archivePredicate,urgentPredicate])
        request.predicate = compoundPredicate
        
        
        
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    
    func getPersonalItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
       
        
        let archivePredicate = NSPredicate(format: "isArchived == 0")
        let personalPredicate = NSPredicate(format: "category == 'Personal'")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [archivePredicate,personalPredicate])
        request.predicate = compoundPredicate
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    func getWorkItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
        let archivePredicate = NSPredicate(format: "isArchived == 0")
        let workPredicate = NSPredicate(format: "category == 'Work'")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [archivePredicate,workPredicate])
        request.predicate = compoundPredicate
        
        
        
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    
    func getArchivedItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
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
    
    func updateItem(item:NewTask, newTaskName:String, description:String, date:Date?, category:String?){
        item.task = newTaskName
        item.taskDescription = description
        item.date = date
        item.category = category
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func getSchoolItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
        let archivePredicate = NSPredicate(format: "isArchived == 0")
        let schoolPredicate = NSPredicate(format: "category == 'School'")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [archivePredicate,schoolPredicate])
        request.predicate = compoundPredicate
        
        
        
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    func getHomeItems(){
        let request:NSFetchRequest<NewTask> = NewTask.fetchRequest()
        let doneSort = NSSortDescriptor(key: "done", ascending: true)
        let alphabetSort = NSSortDescriptor(key: "task", ascending: true)
        request.sortDescriptors = [doneSort,alphabetSort]
        let archivePredicate = NSPredicate(format: "isArchived == 0")
        let homePredicate = NSPredicate(format: "category == 'Home'")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [archivePredicate,homePredicate])
        request.predicate = compoundPredicate
        
        
        
        do{
            models = try context.fetch(request)
            
           
            
        }catch{
            print("Error fetching data")
        }
    }
    
}

//
//  DataProvider.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/09/01.
//

import Foundation
import UIKit

class DataProvider{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [NewTask]()
    
    func getAllItems(){
      
        
        do{
            models = try context.fetch(NewTask.fetchRequest())
            
           
            
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
    
    func updateItem(item:NewTask, newTaskName:String, description:String){
        item.task = newTaskName
        item.taskDescription = description
        do{
            try context.save()
        }catch{
            
        }
    }
    
}

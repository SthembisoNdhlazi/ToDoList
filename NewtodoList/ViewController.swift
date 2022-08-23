//
//  ViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/19.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
   

    @IBOutlet weak var tableView: UITableView!
    
  
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [NewTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllItems()
       title = "To do list📝"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getAllItems(){
        do{
             models = try context.fetch(NewTask.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print("Error fetching data")
        }
    }
    
    func createItem(task:String){
        let newItem = NewTask(context: context)
        newItem.task = task
        newItem.done = false
        
        do{
            try context.save()
            getAllItems()
            tableView.reloadData()
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
    
    func updateItem(item:NewTask, newTaskName:String){
        item.task = newTaskName
        
        do{
            try context.save()
        }catch{
            
        }
    }

 
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editAlert = UIAlertController(title: "edit task📝", message: "Edit task", preferredStyle: .alert)
        let item = models[indexPath.row]
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            
            guard let textField = editAlert.textFields?.first, let taskToUpdate = textField.text else{
                return
            }
           
            
            self.updateItem(item: item, newTaskName: taskToUpdate)
            self.tableView.reloadData()
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        editAlert.addTextField()
        editAlert.addAction(saveAction)
        editAlert.addAction(cancelAction)
        present(editAlert, animated: true)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = models[indexPath.row]
            commit.managedObjectContext?.delete(commit)
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do{
                try commit.managedObjectContext?.save()
            } catch {
                print("Couldn't save")
            }
           
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
       // cell.textLabel?.text = task.value(forKey: "task") as? String
        cell?.setUpCell(task: model.task!)
        return cell!
    }
    
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New task", message: "Add a new task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let textField = alert.textFields?.first, let taskToSave = textField.text else{
                return
            }
           
            self.createItem(task: taskToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
   
    
}


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
    
    var newtasks:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "To do list📝"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewTask")
        
        do{
            newtasks = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Could not fetch data... \(error), \(error.userInfo)")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editAlert = UIAlertController(title: "edit task📝", message: "Edit task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let textField = editAlert.textFields?.first, let taskToUpdate = textField.text else{
                return
            }
           
            UpdateTasks(taskToUpdate: taskToUpdate, indexPath: indexPath)
            self.tableView.reloadData()
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        editAlert.addTextField()
        editAlert.addAction(saveAction)
        editAlert.addAction(cancelAction)
        present(editAlert, animated: true)
    }
    
    func UpdateTasks(taskToUpdate:String, indexPath:IndexPath){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewTask")
        
        do{
            let results = try context?.fetch(fetchRequest) as? [NSManagedObject]
            results?[indexPath.row].setValue(taskToUpdate, forKey: "task")
        }catch{
            print("Fetch failed")
        }
        
        do{
            try context?.save()
        }catch{
            print("Save failed")
        }
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = newtasks[indexPath.row]
            commit.managedObjectContext?.delete(commit)
            newtasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do{
                try commit.managedObjectContext?.save()
            } catch {
                print("Couldn't save")
            }
           
        }
    }
    /* this following function works, you can add an edit button and delete a cell, but it needs some work
     
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "edit") {(action, indexPath) in
            
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "del"){(action, indexPath) in
            
        }
        
        return [editAction,deleteAction]
    }
    
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newtasks.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let task = newtasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = task.value(forKey: "task") as? String

        return cell
    }
    
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New task", message: "Add a new task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            
            guard let textField = alert.textFields?.first, let taskToSave = textField.text else{
                return
            }
           
            self.save(task:taskToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func save(task:String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "NewTask", in: managedContext)!
        
        let tasks = NSManagedObject(entity: entity, insertInto: managedContext)
        
        tasks.setValue(task, forKey: "task")
        
        do{
            try managedContext.save()
            newtasks.append(tasks)
        }catch let error as NSError{
            print("Couldn't save... \(error), \(error.userInfo)")
        }
        
    }
    
}


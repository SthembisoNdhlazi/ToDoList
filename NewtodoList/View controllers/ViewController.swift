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
       title = "To do list"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        newItem.isArchived = false
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = models[indexPath.row]
        
        if item.isArchived{
            return 0
        } else {
            return 100
        }
        
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete"){ (action, view, completionHandler) in
            let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .default){
                [unowned self] action in
                
                let commit = self.models[indexPath.row]
                commit.managedObjectContext?.delete(commit)
                self.models.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                do{
                    try commit.managedObjectContext?.save()
                } catch {
                    print("Couldn't save")
                }
                
            
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            deleteAlert.addAction(deleteAction)
            deleteAlert.addAction(cancelAction)
            
            self.present(deleteAlert, animated: true)
        }
        
        let archive = UIContextualAction(style: .normal, title: "Archive"){ (action, view, completionHandler) in
            
            let commit = self.models[indexPath.row]
            commit.isArchived.toggle()
            print(commit.isArchived)
            tableView.reloadData()
            do{
                try commit.managedObjectContext?.save()
            } catch {
                print("Couldn't save")
            }
        }
        
        archive.backgroundColor = .blue
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        //swipe action to return
        let swipe = UISwipeActionsConfiguration(actions: [delete,archive])
        return swipe
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    performSegue(withIdentifier: "viewTask", sender: indexPath)
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
       
        cell?.setUpCell(task: model.task!,isDone: model.done)
        cell?.isDoneDelegate = self
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
    
    func toggleDone(for index:Int){
        
        
        models[index].done.toggle()
        do{
            try context.save()
        }catch{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditVC{
            destination.indexPath = tableView.indexPathForSelectedRow?.row
            
        }
    }
    
}

extension ViewController:isDone{
    func toggleIsDone(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            toggleDone(for: indexPath.row)
            tableView.reloadData()
        }
    }
}


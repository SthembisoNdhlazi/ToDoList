//
//  ViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/19.
//

import UIKit
import CoreData
import SwiftUI



class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
   
  
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "All tasks"){ (action) in
                self.dataProvider.getAllItems()
                self.tableView.reloadData()
            },
            UIAction(title: "Work tasks"){ (action) in
                self.dataProvider.getWorkItems()
                self.tableView.reloadData()
            },
            UIAction(title: "School tasks"){ (action) in
                self.dataProvider.getSchoolItems()
                self.tableView.reloadData()
            },
            UIAction(title: "Personal tasks"){ (action) in
                self.dataProvider.getPersonalItems()
                self.tableView.reloadData()
            },
            UIAction(title: "Home tasks"){ (action) in
                self.dataProvider.getHomeItems()
                self.tableView.reloadData()
            },
            UIAction(title: "Urgent tasks"){ (action) in
                self.dataProvider.getUrgentItems()
                self.tableView.reloadData()
            }
           
        ]
    }
    
    var demoMenu: UIMenu {
        return UIMenu(title: "Filter tasks", image: nil, identifier: nil, options: [], children: menuItems)
    }
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    let dataProvider = DataProvider()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.getAllItems()
        
       title = "To do list"
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        filterButton.menu = demoMenu
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataProvider.getAllItems()
        tableView.reloadData()
    }
    
  
    

    
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete"){ (action, view, completionHandler) in
            let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .default){
                [unowned self] action in
                
                let commit = dataProvider.models[indexPath.row]
                commit.managedObjectContext?.delete(commit)
                dataProvider.models.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                dataProvider.getAllItems()
                tableView.reloadData()
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
        
        let archive = UIContextualAction(style: .normal, title: "Archive"){ [self] (action, view, completionHandler) in
            
            let commit = dataProvider.models[indexPath.row]
            commit.isArchived.toggle()
            print(commit.isArchived)
            dataProvider.getAllItems()
            tableView.reloadData()
            do{
                try commit.managedObjectContext?.save()
            } catch {
                print("Couldn't save")
            }
        }
        
        archive.backgroundColor = .black
        archive.image = UIImage(systemName: "archivebox")
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .white
        delete.backgroundColor = .gray
    
        //swipe action to return
        let swipe = UISwipeActionsConfiguration(actions: [delete,archive])
        return swipe
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    performSegue(withIdentifier: "viewTask", sender: indexPath)
        
        
     
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataProvider.models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = dataProvider.models[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
       
        cell?.setUpCell(task: model.task!, taskDescription: model.taskDescription ?? "" ,specifiedDate: DateFormatter.localizedString(from: model.date!, dateStyle: .short, timeStyle: .short), isDone: model.done, model: model)
        
        
        cell?.isDoneDelegate = self
        
    
        
        return cell!
    }
    //creating OverdueTasks:
    
 
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
      
    }
    
    func toggleDone(for index:Int){
        
        dataProvider.models[index].done.toggle()
        do{
            try dataProvider.context.save()
        }catch{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditVC{
            destination.indexPath = tableView.indexPathForSelectedRow?.row
            destination.model = dataProvider.models[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
 
    
}

extension ViewController: isDone{
    
    func toggleIsDone(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            toggleDone(for: indexPath.row)
            tableView.reloadData()
          
        }
    }
}


//
//  ArchiveViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/24.
//

import UIKit
import CoreData

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   let dataProvider = DataProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataProvider.getArchivedItems()
       title = "Archived tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataProvider.models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        
      
            
        let model = dataProvider.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
    
        cell?.setUpCell(task: model.task!, taskDescription: model.taskDescription ?? "",specifiedDate: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),isDone: model.done, model: model)
            
            return cell!
       
      
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete"){ [self] (action, view, completionHandler) in
            
            let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            let deleteAction = UIAlertAction(title: "Yes", style: .default){
                [unowned self] action in
            let commit = dataProvider.models[indexPath.row]
            commit.managedObjectContext?.delete(commit)
            dataProvider.models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do{
                try commit.managedObjectContext?.save()
            } catch {
                print("Couldn't save")
            }
            }
            deleteAlert.addAction(deleteAction)
            deleteAlert.addAction(cancelAction)
            
            self.present(deleteAlert, animated: true)
        }
           
            
        let archive = UIContextualAction(style: .normal, title: "Unarchive"){ [self] (action, view, completionHandler) in
            
            let commit = dataProvider.models[indexPath.row]
            commit.isArchived.toggle()
            print(commit.isArchived)
        
            dataProvider.getArchivedItems()
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
    
   

}

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
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataProvider.getAllItems()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Gone...")
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
        print(dataProvider.models[indexPath.row].date)
        
     
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataProvider.models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = dataProvider.models[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
       
        cell?.setUpCell(task: model.task!, taskDescription: model.taskDescription ?? "" ,specifiedDate: DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short), isDone: model.done)
        cell?.isDoneDelegate = self
        return cell!
    }
    
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
       let vc = UIHostingController(rootView: addNewTask())
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
        
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
    
        }
    }
    
}

extension ViewController: isDone{
    
    func toggleIsDone(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            toggleDone(for: indexPath.row)
            tableView.reloadData()
            dataProvider.getAllItems()
        }
    }
}


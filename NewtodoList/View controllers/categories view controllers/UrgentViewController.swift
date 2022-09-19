//
//  UrgentViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/09/07.
//

import UIKit
import SwiftUI

class UrgentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let dataProvider = DataProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider.getUrgentItems()
       title = "Urgent tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        dataProvider.getUrgentItems()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataProvider.models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = dataProvider.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
    
        cell?.setUpCell(task: model.task!, taskDescription: model.taskDescription ?? "",specifiedDate: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),isDone: model.done, model: model)
        cell!.isDoneDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete"){ [self] (action, view, completionHandler) in
            
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
        let archive = UIContextualAction(style: .normal, title: "Archive"){ [self] (action, view, completionHandler) in
            
            let commit = dataProvider.models[indexPath.row]
            commit.isArchived.toggle()
            print(commit.isArchived)
        
            dataProvider.getUrgentItems()
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
    
   
    @IBAction func addTapped(_ sender: Any) {
    
    }
    
    func toggleDone(for index:Int){
        
        dataProvider.models[index].done.toggle()
        do{
            try dataProvider.context.save()
        }catch{
            
        }
    }
}

extension UrgentViewController: isDone{
    
    func toggleIsDone(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            toggleDone(for: indexPath.row)
            tableView.reloadData()
            dataProvider.getUrgentItems()
        }
    }
}

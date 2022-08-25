//
//  ArchiveViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/24.
//

import UIKit

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [NewTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getAllItems()
       title = "Archived tasks📨"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(systemName: "pencil"))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        models.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
       
        cell?.setUpCell(task: model.task!,isDone: model.done)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete"){ (action, view, completionHandler) in
            
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
        let archive = UIContextualAction(style: .normal, title: "UnArchive"){ (action, view, completionHandler) in
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = models[indexPath.row]
        
        if item.isArchived{
            return 100
        } else {
            return 0
        }
        
    }

}

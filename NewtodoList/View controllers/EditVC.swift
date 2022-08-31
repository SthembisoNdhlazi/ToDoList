//
//  EditViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/30.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var text: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [NewTask]()
    var indexPath:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       getAllItems()
        text.text = models[indexPath!].task
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let item = models[indexPath!]
        let taskToUpdate = text.text
        
        updateItem(item: item, newTaskName: taskToUpdate!)
        
     
        self.navigationController?.popToRootViewController( animated: true)
        
    }
    func getAllItems(){

        do{
            models = try context.fetch(NewTask.fetchRequest())
            
        }catch{
            print("Error fetching data")
        }
    }
    
    func updateItem(item: NewTask, newTaskName: String){
        item.task = newTaskName
        
        do{
            try context.save()
        }catch{
            
        }
    }

}

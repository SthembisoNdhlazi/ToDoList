//
//  NewTaskViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/31.
//

import UIKit

class NewTaskViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [NewTask]()
    
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.placeholder = "Enter a new task"
    }
    
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
    
    
    @IBAction func saveTapped(_ sender: Any) {
        
        createItem(task: text.text!)
        self.navigationController?.popToRootViewController( animated: true)
        
    }
    

}

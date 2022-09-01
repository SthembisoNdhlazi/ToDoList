//
//  EditViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/30.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var text: UITextField!
   let dataProvider = DataProvider()
    
    var indexPath:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider.getAllItems()
        text.text = dataProvider.models[indexPath!].task
        if ((dataProvider.models[indexPath!].taskDescription?.isEmpty) != nil){
            descriptionView.text = dataProvider.models[indexPath!].taskDescription
        }else{
            descriptionView.text = "this task doesn't have a description. \nAdd one"
        }
        
        descriptionView.layer.borderWidth = 0.5
        descriptionView.layer.cornerRadius = descriptionView.frame.size.height / 10
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = text.frame.size.height/20
        
        
    }
    

    
    @IBAction func saveTapped(_ sender: Any) {
        let item = dataProvider.models[indexPath!]
        let taskToUpdate = text.text
        let descriptionUpdate = descriptionView.text
        
        dataProvider.updateItem(item: item, newTaskName: taskToUpdate!, description: descriptionUpdate!)
        
     
        self.navigationController?.popToRootViewController( animated: true)
        
    }
 
}

//
//  EditViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/30.
//

import UIKit

class EditVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var text: UITextField!
    var pickerData = ["Work","School", "Urgent", "Home"]
    var selectedCategory: String?
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
        
        datePicker.date = dataProvider.models[indexPath!].date ?? Date()
        
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }
    

    
    @IBAction func saveTapped(_ sender: Any) {
        let item = dataProvider.models[indexPath!]
        let taskToUpdate = text.text
        let descriptionUpdate = descriptionView.text
        
        dataProvider.updateItem(item: item, newTaskName: taskToUpdate!, description: descriptionUpdate!,date: datePicker.date)
        
     
        self.navigationController?.popToRootViewController( animated: true)
        
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = pickerData[row]
    }
}

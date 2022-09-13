//
//  NewTaskViewController.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/09/13.
//

import UIKit

class NewTaskViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var text: UITextField!
    var pickerData = ["Work","School", "Urgent", "Home","Personal"]
    var selectedCategory: String?
   let dataProvider = DataProvider()
    var model : NewTask?
    var indexPath:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        text.placeholder = "Enter the task name"
        
        
       
        
        descriptionView.layer.borderWidth = 0.5
        descriptionView.layer.cornerRadius = descriptionView.frame.size.height / 10
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = text.frame.size.height/20
        
        datePicker.date = model?.date ?? Date()
        
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func saveTapped(_ sender: Any) {
       
        let taskName = text.text
        let description = descriptionView.text
        let date = datePicker.date
        let category = selectedCategory
        
        let newItem = NewTask(context: dataProvider.context)
        
        newItem.task = taskName
        newItem.taskDescription = description
        
        newItem.done = false
        newItem.isArchived = false
        newItem.date = date
        newItem.category = category
        do{
            try dataProvider.context.save()
           
        }catch{
          print("error saving")
        }
        
     
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

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
    var pickerData = ["Work","School", "Urgent", "Home","Personal"]
    var selectedCategory: String?
   let dataProvider = DataProvider()
    var model : NewTask?
    var indexPath:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //dataProvider.getAllItems()
        text.text = model?.task
        
        if ((model?.taskDescription?.isEmpty) != nil){
            descriptionView.text = model?.taskDescription
        }else{
            descriptionView.text = "this task doesn't have a description. \nAdd one"
        }
        
        descriptionView.layer.borderWidth = 0.5
        descriptionView.layer.cornerRadius = descriptionView.frame.size.height / 10
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = text.frame.size.height/20
        
        datePicker.date = model?.date ?? Date()
        
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        selectedCategory = model?.category
        
            if selectedCategory == pickerData[0]{
                picker.selectRow(0, inComponent: 0, animated: true)
                
            }else  if selectedCategory == pickerData[1]{
                picker.selectRow(1, inComponent: 0, animated: true)
            }else if selectedCategory == pickerData[2]{
                picker.selectRow(2, inComponent: 0, animated: true)
            } else  if selectedCategory == pickerData[3]{
                picker.selectRow(3, inComponent: 0, animated: true)
            } else  if selectedCategory == pickerData[4]{
                picker.selectRow(4, inComponent: 0, animated: true)
            }
        
        
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    

    
    @IBAction func saveTapped(_ sender: Any) {
        let item = model
        let taskToUpdate = text.text
        let descriptionUpdate = descriptionView.text
        
        dataProvider.updateItem(item: item!, newTaskName: taskToUpdate!, description: descriptionUpdate!,date: datePicker.date, category: selectedCategory)
        
     
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

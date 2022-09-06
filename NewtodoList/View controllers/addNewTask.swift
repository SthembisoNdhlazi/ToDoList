//
//  addNewTask.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/09/01.
//

import SwiftUI

struct addNewTask: View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var newTaskTitle:String = ""
    @State var description:String = ""
    @State var birthDate = Date()
    var categories = ["Work","School", "Urgent", "Home"]
    @State private var selectedCategory = "Work"
    var body: some View {
        VStack {
            Button{
               dismiss()
            }label:{
                
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15))
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.gray, in: Circle())
                    Spacer()
                }
                
                
            }
            Spacer()
                .frame(height:30)
            Text("Add a new task")
                .font(.largeTitle)
                .bold()
                .padding()
                .padding(.bottom)
            VStack(alignment: .leading){
                Text("Task title")
                    .font(.title2)
                    .bold()
                TextField("Add new task", text: $newTaskTitle)
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 8).stroke())
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            VStack(alignment: .leading){
                Text("Description")
                    .font(.title2)
                    .bold()
                TextField("Enter a description", text: $description)
                    .padding()
                    .frame(width: 400, height: 150)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 10).stroke())
                
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            Spacer()
                .frame(height:25)
            VStack {
                DatePicker(selection: $birthDate, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                           Text("Select a date")
                       }
    
                      
                   }
            VStack {
                HStack{
                    Text("Select a category")
                    Spacer()
                       Picker("Please choose a category", selection: $selectedCategory) {
                           ForEach(categories, id: \.self) {
                               Text($0)
                           }
                       }
                }
                   }
            Button{
                let newItem = NewTask(context: context)
                newItem.task = newTaskTitle
                newItem.taskDescription = description
                
                newItem.done = false
                newItem.isArchived = false
                newItem.date = birthDate
                newItem.category = selectedCategory
                do{
                    try context.save()
                   
                }catch{
                  print("error saving")
                }
                dismiss()
            }label:{
                Text("Save")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 200, height: 50)
                    .background(
                        Color.black
                        .cornerRadius(40)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
                    )
                
            }
           
            Spacer()
                .frame(height:150)
        }
        .padding(.horizontal, 25)
        
    }
}

struct addNewTask_Previews: PreviewProvider {
    static var previews: some View {
        addNewTask()
        
    }
}

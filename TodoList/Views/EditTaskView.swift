//
//  EditTaskView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/24.
//

import SwiftUI

struct EditTaskView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>

    @Environment(\.managedObjectContext) var moc
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var taskItem: Task
    @Binding var title: String
    @Binding var description: String
    @Binding var dueDate: Date
    @Binding var entryDate: Date
    @State var isShowing: Bool = false
    @State var categoryName: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Title")){
                        TextField("", text: $title)
                    }
                    Section(header: Text("Description")){
                        TextField("", text: $description)
                    }
                    Section(header: Text("Due Date")){
                        DatePicker(selection: $dueDate, label: { Text("Date") })
                    }
                    Section(header: Text("Category")){
                        Menu("Select Category"){
                                Button{
                                    isShowing = true
                                    
                                }label: {
                                    Text("Add Category")
                                }
                            
                            
                            ForEach(categories, id: \.self){ category in
                                Button{
//                                    editCategory(taskItem: taskItem, categoryName: category.name ?? "No Category")
                                    categoryName = category.name ?? "No Category"
                                }label:{
                                    Text(category.name ?? "No Category")
                                }
                                
                            }
                        }
                    }
                }
                VStack{
                    Spacer()
                    ZStack {
                        Capsule()
                            .frame(width: 130, height: 50)
                            .foregroundColor(.blue)
                        Button{
                            editTask(categoryName: categoryName, taskItem: taskItem, title: title, description: description, dueDate: dueDate)
                            presentationMode.wrappedValue.dismiss()
                        }label:{
                            Text("Save task")
                        }.foregroundColor(.white)
                    }
                }.padding(.bottom)
            }.navigationTitle("Edit Task")
        }
    }
    
    func editCategory(taskItem: Task, categoryName: String){
        for category in categories {
            if category.name == categoryName {
                taskItem.category = category
                print("added: \n")
                print(taskItem.category)
            }
        }
        try? moc.save()
    }
    
    func editTask(categoryName: String, taskItem: Task, title: String, description: String, dueDate: Date){
        taskItem.title = title
        taskItem.taskDescription = description
        taskItem.dueDate = dueDate
        
        for category in categories {
            if category.name == categoryName {
                taskItem.category = category
                print("added: \n")
                print(taskItem.category)
            }
        }
        
        try? moc.save()
    }
}

//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView()
//    }
//}

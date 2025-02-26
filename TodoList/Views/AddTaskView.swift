//
//  InputView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct AddTaskView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc
    @Environment (\.presentationMode) var presentationMode
    
    var provider = Provider()
    @State var title: String = ""
    @State var description: String = ""
    @State var dueDate = Date()
    @State var entryDate = Date()
    @State var isShowing: Bool = false
    @State var categoryName: String = ""
    var body: some View {
//        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("", text: $title)
                    }
                    
                    Section(header: Text("Description")){
                        TextField("", text: $description)
                    }
                    Section(header: Text("Date")){
                        DatePicker(selection: $dueDate, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
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
                .textFieldAlert(isShowing: $isShowing, text: $categoryName, title: "Add New Category")
                
                    
                VStack{
                    Spacer()
                    ZStack {
                        Capsule()
                            .frame(width: 130, height: 50)
                            .foregroundColor(.blue)
                        Button{
                            addTask(categoryName: categoryName, title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: false, isArchived: false)
                            presentationMode.wrappedValue.dismiss()
                        }label:{
                            Text("Add task")
                        }.foregroundColor(.white)
                    }
                }.padding(.bottom)
            }.navigationTitle("Add Task")
//        }
        
        
    }
    
    
    
    
    
    func addTask(categoryName: String, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = title
        task.taskDescription = description
        task.entryDate = entryDate
        task.dueDate = dueDate
        task.isDone = isDone
        task.isArchived = isArchived
        for category in categories {
            if category.name == categoryName {
                task.category = category
                print("added: \n")
                print(task.category)
            }
        }
        try? moc.save()
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlertComponent(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}

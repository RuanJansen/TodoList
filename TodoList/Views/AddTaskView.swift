//
//  InputView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct AddTaskView: View {
//    @FetchRequest(sortDescriptors: [], predicate: nil) var tasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc
    @Environment (\.presentationMode) var presentationMode
    var provider = Provider()
    @State var title: String = ""
    @State var categoryName: String = ""
    
    @State var parentCategory: Category?
    @State var description: String = ""
    @State var dueDate = Date()
    @State var entryDate = Date()
    
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
                    
                    Section(header: Text("Categories")) {
                        TextField("", text: $categoryName)
                        Menu("Select Category") {
                            VStack {
                                Button {
                                    
                                } label: {
                                    Text("Add Category")
                                    }
                                ForEach(categories, id: \.self) {category in
                                    Text(category.name ?? "No Categories Added")
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
                            addCategory(name: categoryName)
                            parentCategory?.name = categoryName
                            
                            addTask(title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: false, isArchived: false, categoryName: categoryName)
                            
                        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                            
                            presentationMode.wrappedValue.dismiss()
                        }label:{
                            Text("Add task")
                        }.foregroundColor(.white)
                    }
                    
                    
                    
                }.padding(.bottom)
            }.navigationTitle("Add Task")
//        }
    }
    
    func addTask(title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool, categoryName: String){
//        var categoryItem: FetchedResults<Category>.Element
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
                task.categoryParent = category
                print("added: \n")
                print(task.categoryParent)
            }
        }
        
        try? moc.save()
    }
    
    func addCategory(name: String) {
        let newCat = Category(context: moc)
        newCat.name = name

        try? moc .save()
        print("Saved")
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

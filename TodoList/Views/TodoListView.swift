//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc
    var provider = Provider()
    @State var filterDone = true
    @State var filterActive = false
    @State var showAddTask = false
    @State var isOverdue = false
    @State var isNotOverdue = true
    @State var categoryParent = ""
    @State var selectedCategory = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
//                        Button {
//                           addCategory(name: "Groceries")
//                        } label: {
//                            ZStack {
//                                Capsule()
//                                    .frame(width: 50, height: 25, alignment: .center)
//                                    .foregroundColor(.blue)
//                                Text("Add")
//                                    .foregroundColor(.white)
//                            }
//                        }
                        
                        ForEach(categories, id: \.self) {category in
                            Button() {
                                selectedCategory = category.name!
//                                @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "categoryParent.name MATCHES %@", parentCategory!.name!)) var tasks: FetchedResults<Task>
                            } label: {
                                ZStack {
                                    Capsule()
                                        .frame(width: 100, height: 25, alignment: .center)
                                        .foregroundColor(.blue)
                                    Text(category.name!)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                List{
                    Section {
                        TaskList(provider: provider, filterDone: $filterActive, isOverdue: $isOverdue, selectedCategory: $selectedCategory)
                    }header: {
                        Text("Overdue")
                    }
                    
                    Section {
                        
                        
                        TaskList(provider: provider, filterDone: $filterActive, isOverdue: $isNotOverdue, selectedCategory: $selectedCategory)
                        
                        
                        
                    }header: {
                        Text("Active")
                    }
                    
                    Section {
                        TaskList(provider: provider, filterDone: $filterDone, isOverdue: $isOverdue, selectedCategory: $selectedCategory)
                    }header: {
                        Text("Done")
                    }
                    
                    
                    
                }
                .sheet(isPresented: $showAddTask){
                    AddTaskView()
                }
                .toolbar {
                    //                    ToolbarItem(placement: .navigationBarLeading){
                    //                        EditButton()
                    //                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ArchivedListView()){
                            Label("Archive", systemImage: "archivebox")
                            //                                .font(.headline)
                        }
                    }
                    ToolbarItem {
                        Button{
                            showAddTask = true
                        }label: {
                            Label("Add", systemImage: "plus")
                            //                                .font(.headline)
                        }
                    }
                }   
            }.navigationTitle("To Do")
        }
    }
    
//    func addCategory(name: String) {
//        let newCat = Category(context: moc)
//        newCat.name = name
//
//        try? moc .save()
//        print("Saved")
//    }
    
    func populateMocTasks(){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = "Do Dishes"
        task.taskDescription = "I need to wash last night's dishes."
        task.entryDate = Date()
        task.dueDate = Date()
        task.isDone = false
        task.isArchived = false
        
    }
    
    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = title
        task.taskDescription = description
        task.entryDate = entryDate
        task.dueDate = dueDate
        task.isDone = isDone
        task.isArchived = isArchived
        try? moc.save()
    }
}

struct TaskList: View {
    var provider = Provider()
    @Binding var filterDone: Bool
    @Binding var isOverdue: Bool
    @Binding var selectedCategory: String
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        ForEach(tasks.filter {
            ($0.categoryParent?.name == selectedCategory) && (!$0.isArchived && $0.isDone == filterDone) && (calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
            
        }){ task in
            var taskItem = task
            HStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                    if task.isDone {
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough()
                    } else {
                        Text("\(task.title ?? "Unknown")")
                    }
                    
                    Spacer()
                    Text("\(task.dueDate ?? Date(), formatter: TaskList.dateFormatter )")
                }
            }
            .swipeActions(edge: .trailing){
                Button{
                    archiveTask(task: task)
                } label: {
                    Label("Archive", systemImage: "archivebox")
                }.tint(.blue)
            }
            .swipeActions(edge: .leading){
                Button{
                    doneTask(task: task)
                } label: {
                    Label("Done", systemImage: "checkmark")
                }.tint(.blue)
            }
        }
        .onMove(perform: { indices, newOffset in
            provider.moveTask(indices: indices, newOffset: newOffset)
        })
    }
    
    func calcIsOverdue(dueDate: Date) -> Bool{
        if dueDate > Date(){
            return true
        }else{
            return false
        }
    }
    func doneTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}











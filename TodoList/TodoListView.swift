//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    let provider = Provider()
//    var taskItem: Task
//    @EnvObj var taskItem: Task?
    @State var showAddTask = false
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"

        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section {
                        ForEach(tasks.filter {!$0.isArchived && $0.isDone}){ task in
                            var taskItem = task
                            HStack {
                                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                                        Text("\(task.title ?? "Unknown")")
                                            .strikethrough()
                                    Spacer()
                                    Text("\(task.dueDate ?? Date(), formatter: Self.dateFormatter )")
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
    //                    .onDelete(perform: provider.removeTask)
                        .onMove(perform: { indices, newOffset in
                            provider.moveTask(indices: indices, newOffset: newOffset)
                    })
                    }header: {
                        Text("Done")
                    }
                    
                    Section {
                        ForEach(tasks.filter {!$0.isArchived && !$0.isDone}){ task in
                            var taskItem = task
                            HStack {
                                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                                    
                                        Text("\(task.title ?? "Unknown")")
                                    
                                    
                                    Spacer()
                                    Text("\(task.dueDate ?? Date(), formatter: Self.dateFormatter )")
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
    //                    .onDelete(perform: provider.removeTask)
                        .onMove(perform: { indices, newOffset in
                            provider.moveTask(indices: indices, newOffset: newOffset)
                    })
                    }header: {
                        Text("Active")
                    }
                    
                }
                .sheet(isPresented: $showAddTask){
                    AddTaskView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
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
    
    func doneTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
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



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}



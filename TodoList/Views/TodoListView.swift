//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
//    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
//    @Environment(\.managedObjectContext) var moc
//    let provider = Provider()
    //    let persistenceManager = persistenceManager.shared
    var provider = Provider()
    @State var filterDone = true
    @State var filterActive = false
    @State var showAddTask = false
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section {
                        TaskList(filterDone: $filterDone, provider: provider)
                    }header: {
                        Text("Done")
                    }
                    Section {
                        TaskList(filterDone: $filterActive, provider: provider)
                    }header: {
                        Text("Active")
                    }
                }
                .sheet(isPresented: $showAddTask){
                    AddTaskView(provider: provider)
                }
                .toolbar {
                    //                    ToolbarItem(placement: .navigationBarLeading){
                    //                        EditButton()
                    //                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ArchivedListView()){
                            Label("Archive", systemImage: "archivebox")
                        }
                    }
                    ToolbarItem {
                        Button{
                            showAddTask = true
                        }label: {
                            Label("Add", systemImage: "plus")
                        }
                        
                    }
                }
            }.navigationTitle("To Do")
        }
    }
}

struct TaskList: View {
    @Binding var filterDone: Bool
    var provider: Provider
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    var body: some View {
//        VStack {
            ForEach(tasks.filter {
                !$0.isArchived && $0.isDone == filterDone
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
                        Text("\(task.dueDate ?? Date(), formatter: Provider.dateFormatter )")
                    }
                }
                .swipeActions(edge: .trailing){
                    Button{
                        provider.archiveTasks(task: task)
                    } label: {
                        Label("Archive", systemImage: "archivebox")
                        
                    }.tint(.blue)
                }
                .swipeActions(edge: .leading){
                    Button{
                        provider.doneTasks(task: task)
                    } label: {
                        Label("Done", systemImage: "checkmark")
                    }.tint(.blue)
                }
                
            }
            .onMove(perform: { indices, newOffset in
                provider.moveTask(indexSet: indices, newOffset: newOffset)
            })
//        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

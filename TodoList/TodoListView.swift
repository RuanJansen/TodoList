//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    
    
    let provider: TaskProviding
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
                        ForEach(provider.getTasks().filter {!$0.isArchived && $0.isDone}){ task in
                            var taskItem = task
                            HStack {
                                NavigationLink(destination: TaskView(taskItem: task)){
                                    
                                        Text("\(task.title ?? "Unknown")")
                                            .strikethrough()
                                    
                                    
                                    Spacer()
                                    Text("\(task.dueDate ?? Date(), formatter: Self.dateFormatter )")
                                }
                            }
                            .swipeActions(edge: .trailing){
                                Button{
                                    provider.archiveTask(task: task)
                                } label: {
                                    Label("Archive", systemImage: "archivebox")
                                        
                                }.tint(.blue)
                            }
                            .swipeActions(edge: .leading){
                                Button{
                                    provider.doneTask(task: task)
                                } label: {
                                    Label("Done", systemImage: "checkmark")
                                }.tint(.blue)
                            }
                                                   
                        }
    //                    .onDelete(perform: viewController.removeTask)
                        .onMove(perform: { indices, newOffset in
                            provider.moveTask(indices: indices, newOffset: newOffset)
                    })
                    }header: {
                        Text("Done")
                    }
                    
                    Section {
                        ForEach(provider.getTasks().filter {!$0.isArchived && !$0.isDone}){ task in
                            var taskItem = task
                            HStack {
                                NavigationLink(destination: TaskView(taskItem: task)){
                                    
                                        Text("\(task.title ?? "Unknown")")
                                    
                                    
                                    Spacer()
                                    Text("\(task.dueDate ?? Date(), formatter: Self.dateFormatter )")
                                }
                            }
                            .swipeActions(edge: .trailing){
                                Button{
                                    provider.archiveTask(task: task)
                                } label: {
                                    Label("Archive", systemImage: "archivebox")
                                        
                                }.tint(.blue)
                            }
                            .swipeActions(edge: .leading){
                                Button{
                                    provider.doneTask(task: task)
                                } label: {
                                    Label("Done", systemImage: "checkmark")
                                }.tint(.blue)
                            }
                                                   
                        }
    //                    .onDelete(perform: viewController.removeTask)
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
    
    
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}



//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    let viewController = TodoListViewController()
    @State var taskItem: Tasks
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(viewController.tasks.filter {!$0.isArchived}){ task in
                        var taskItem = task
                                                
                        HStack {
                            NavigationLink(destination: TaskView(task: $taskItem)){
                                Text("\(task.title)")
                                Spacer()
                                Text("\(task.dueDate.formatted())")
                            }
                        }
                        .swipeActions(edge: .trailing){
                            Button{
                                viewController.archiveTask()
                            } label: {
                                Label("Archive", systemImage: "archivebox.fill")
                            }.tint(.blue)
                        }
                        .swipeActions(edge: .leading){
                            Button{
                                viewController.doneTask()
                            } label: {
                                Label("Done", systemImage: "checkmark")
                            }.tint(.blue)
                        }
                                               
                    }
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ArchivedListView()){
                            Label("Archive", systemImage: "archivebox.circle.fill")
                        }
                    }
                    ToolbarItem {
                        NavigationLink(destination: AddTaskView()){
                            Label("Add", systemImage: "plus.circle.fill")
                        }
                    }
                }
            }.navigationTitle("Todo")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}

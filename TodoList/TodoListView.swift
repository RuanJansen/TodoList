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
                List(viewController.tasks.filter {!$0.isArchived}){ task in
                    var taskItem = task
                    NavigationLink(destination: TaskView(task: $taskItem)){
                        VStack {
                            HStack{
                                Text("\(task.title)")
                                Spacer()
                            }
                            HStack{
                                Text("\(task.dueDate.formatted())")
                                Spacer()
                            }
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
                        NavigationLink(destination: AddView()){
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

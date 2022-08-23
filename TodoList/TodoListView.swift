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
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"

        return formatter
    }()
    
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
                                Text("\(task.dueDate, formatter: Self.dateFormatter)")
                            }
                        }
                        .swipeActions(edge: .trailing){
                            Button{
//                                viewController.archiveTask()
                            } label: {
                                Label("Archive", systemImage: "archivebox")
                                    
                            }.tint(.blue)
                        }
                        .swipeActions(edge: .leading){
                            Button{
//                                viewController.doneTask()
                            } label: {
                                Label("Done", systemImage: "checkmark")
                            }.tint(.blue)
                        }
                                               
                    }
                    .onDelete(perform: viewController.removeTask)
                    .onMove(perform: { indices, newOffset in
                        viewController.moveTask(indices: indices, newOffset: newOffset)
                    })
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ArchivedListView()){
                            Label("Archive", systemImage: "archivebox")
                                .font(.headline)
                        }
                    }
                    ToolbarItem {
                        NavigationLink(destination: AddTaskView()){
                            Label("Add", systemImage: "plus")
                                .font(.headline)
                        }
                    }
                }
            }.navigationTitle("Todo")
        }
    }
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}

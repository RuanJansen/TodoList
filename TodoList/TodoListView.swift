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
            List(viewController.tasks.filter {!$0.isArchived}){ task in
//                ForEach(viewController.tasks, id: \.title){ task in
                    var taskItem = task
                    NavigationLink(destination: TaskView(task: $taskItem)){
//                        if !task.isArchived{
                            VStack {
                                HStack{
                                    Text("\(task.title)")
                                    Spacer()
                                    
                                }
                                HStack{
                                    Text("\(task.dueDate.formatted())")
                                    Spacer()
                                }
                            }.padding()
//                        }
                        
                    }
//                }
            }.navigationTitle("Todo")
        }
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}

//
//  InfoView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TaskView: View {
    var taskItem: Task
    
    //published var parsing
    
//    @State var title = taskItem?.title ?? "Unknown Task"
//    @State var description = taskItem?.taskDescription ?? "No description"
//    @State var entryDate = taskItem?.entryDate ?? Date()
//    @State var dueDate = taskItem?.dueDate ?? Date()
    //    var viewController = TodoListViewController()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE HH:mm"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    VStack {
                        Text("Entry Date")
                        Text(taskItem.entryDate ?? Date(), formatter: Self.dateFormatter)
                        Text(taskItem.entryDate ?? Date(), formatter: Self.timeFormatter)
                    }
                    Spacer()
                    VStack {
                        Text("Due Date")
                        Text(taskItem.dueDate ?? Date(), formatter: Self.dateFormatter)
                        Text(taskItem.dueDate ?? Date(), formatter: Self.timeFormatter)
                    }
                }.padding(.bottom)
                HStack {
                    Text("Description")
                    Spacer()
                }.padding(.bottom).font(.title2)
                
                ScrollView {
                    Text(taskItem.taskDescription ?? "No description")
//                    TextEditor(text: $task?.taskDescription ?? "No description")
                }
                .frame(height: 200)
                Spacer()
            }
        }
        .navigationTitle(taskItem.title ?? "Unknown task").padding()
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}

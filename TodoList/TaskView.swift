//
//  InfoView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Tasks
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
                        Text("\(task.entryDate, formatter: Self.dateFormatter)")
                        Text("\(task.entryDate, formatter: Self.timeFormatter)")
                    }
                    Spacer()
                    VStack {
                        Text("Due Date")
                        Text("\(task.dueDate, formatter: Self.dateFormatter)")
                        Text("\(task.entryDate, formatter: Self.timeFormatter)")
                    }
                }.padding(.bottom)
                HStack {
                    Text("Description")
                    Spacer()
                }.padding(.bottom).font(.title2)
                
                ScrollView {
                    Text("\(task.description)")
                }
                .frame(height: 200)
                Spacer()
            }
        }.navigationTitle("\(task.title)").padding()
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}

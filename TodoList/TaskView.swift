//
//  InfoView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Tasks
    var viewController = TodoListViewController()
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack{
                        Text("\(task.entryDate.formatted())")
                        Spacer()
                        Text("\(task.dueDate.formatted())")
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
                
                VStack{
                    Spacer()
                    HStack{
                        ZStack {
                            Capsule()
                                .frame(width: 130, height: 50)
                                .foregroundColor(.green)
                            Button("Mark as done") {
                                viewController.archiveTask()
                            }.foregroundColor(.white)
                        }
                        Spacer()
                        ZStack {
                            Capsule()
                                .frame(width: 130, height: 50)
                                .foregroundColor(.blue)
                            Button("Archive") {
                                viewController.archiveTask()
                            }.foregroundColor(.white)
                        }
                    }.padding(.bottom)
                }
            }.navigationTitle("\(task.title)").padding()
        }
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}

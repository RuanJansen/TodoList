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
            
        }.navigationTitle("\(task.title)").padding()
        
        
        
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}

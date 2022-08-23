//
//  InputView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct AddTaskView: View {
    var viewController = TodoListViewController()
    @State var title: String = ""
    @State var description: String = ""
    @State var dueDate = Date()
    @State var entryDate = Date()
     var body: some View {
         NavigationView {
             ZStack {
                 VStack {
                    HStack{
                        Text("Title")
                        Spacer()
                        TextField("", text: $title)
                        
                    }.padding(.top)
                     Divider()
                    HStack{
                        Text("Description")
                        Spacer()
                        TextField("", text: $description).background()
                        
                    }.padding(.top)
                     Divider()
                    HStack{
                        DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    }.padding(.top)
                    Spacer()
                    Spacer()
                 }.padding()
                 VStack{
                     Spacer()
                     ZStack {
                         Capsule()
                             .frame(width: 130, height: 50)
                             .foregroundColor(.blue)
                         Button("Add task") {
                             viewController.addTask(title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: false, isArchived: false)
                         }.foregroundColor(.white)
                     }
                 }.padding(.bottom)
             }.navigationTitle("Add Task")
         }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

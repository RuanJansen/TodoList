//
//  EditTaskView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/24.
//

import SwiftUI

struct EditTaskView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    @Binding var taskItem: Task
    @Binding var title: String
    @Binding var description: String
    @Binding var dueDate: Date
    @Binding var entryDate: Date
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Section {
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
                       DatePicker(selection: $dueDate, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                   }.padding(.top)
                   Spacer()
                   Spacer()
                }.padding()
            }
            VStack{
                Spacer()
                ZStack {
                    Capsule()
                        .frame(width: 130, height: 50)
                        .foregroundColor(.blue)
                    Button{
                        editTask(taskItem: taskItem, title: title, description: description, dueDate: dueDate)
                        presentationMode.wrappedValue.dismiss()
                    }label:{
                        Text("Save task")
                    }.foregroundColor(.white)
                }
            }.padding(.bottom)
        }
    }
    func editTask(taskItem: Task, title: String, description: String, dueDate: Date){
        taskItem.title = title
        taskItem.taskDescription = description
        taskItem.dueDate = dueDate
        try? moc.save()
    }
}

//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView()
//    }
//}

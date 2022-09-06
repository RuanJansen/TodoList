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
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var taskItem: Task
    @Binding var title: String
    @Binding var description: String
    @Binding var dueDate: Date
    @Binding var entryDate: Date
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Title")){
                        TextField("", text: $title)
                    }
                    Section(header: Text("Description")){
                        TextField("", text: $description)
                    }
                    Section(header: Text("Due Date")){
                        DatePicker(selection: $dueDate, label: { Text("Date") })
                    }
                    
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
            }.navigationTitle("Edit Task")
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

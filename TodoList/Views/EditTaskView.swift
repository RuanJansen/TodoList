//
//  EditTaskView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/24.
//

import SwiftUI

struct EditTaskView: View {
    @Environment (\.presentationMode) var presentationMode
    var provider = Provider()
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
                            
                            provider.editTask(taskItem: taskItem, title: title, description: description, dueDate: dueDate)
                            presentationMode.wrappedValue.dismiss()
                        }label:{
                            Text("Save task")
                        }.foregroundColor(.white)
                    }
                }.padding(.bottom)
            }.navigationTitle("Edit Task")
        }
    }
    
}

//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView(taskItem: <#Binding<Task>#>, title: <#Binding<String>#>, description: <#Binding<String>#>, dueDate: <#Binding<Date>#>, entryDate: <#Binding<Date>#>)
//    }
//}

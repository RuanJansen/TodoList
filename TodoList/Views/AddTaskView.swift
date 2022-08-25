//
//  InputView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct AddTaskView: View {
    @Environment (\.presentationMode) var presentationMode
    var provider = Provider()
    @State var title: String = ""
    @State var description: String = ""
    @State var dueDate = Date()
    @State var entryDate = Date()
    var body: some View {
            ZStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("", text: $title)
                    }
                    Section(header: Text("Description")){
                        TextField("", text: $description)
                    }
                    Section(header: Text("Date")){
                        DatePicker(selection: $dueDate, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    }
                }
                VStack{
                    Spacer()
                    ZStack {
                        Capsule()
                            .frame(width: 130, height: 50)
                            .foregroundColor(.blue)
                        Button{
                            provider.addTask(title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: false, isArchived: false)
                            presentationMode.wrappedValue.dismiss()
                        }label:{
                            Text("Add task")
                        }.foregroundColor(.white)
                    }
                }.padding(.bottom)
            }.navigationTitle("Add Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

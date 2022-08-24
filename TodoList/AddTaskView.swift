//
//  InputView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct AddTaskView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    @Environment (\.presentationMode) var presentationMode
    var viewController = Provider()
    @State var title: String = ""
    @State var description: String = ""
    @State var dueDate = Date()
    @State var entryDate = Date()
     var body: some View {
         NavigationView {
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
                             addTask(title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: false, isArchived: false)
                             presentationMode.wrappedValue.dismiss()
                         }label:{
                             Text("Add task")
                         }.foregroundColor(.white)
                     }
                 }.padding(.bottom)
             }.navigationTitle("Add Task")
         }
    }
    
    func addTask(title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = title
        task.taskDescription = description
        task.entryDate = entryDate
        task.dueDate = dueDate
        task.isDone = isDone
        task.isArchived = isArchived
        
        try? moc.save()
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

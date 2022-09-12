//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    var provider = Provider()
    @State var showAddTask = false
    @State var isCompleted = false
    @State var isOverdue = false
    @State var showWeek = true
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Button{
                        withAnimation{
                            showWeek = true
                        }
                    }label:{
                        ZStack{
                            Capsule()
                                .opacity(showWeek ? 1 : 0)
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 25)
                            Text("Week")
                                .foregroundColor(showWeek ? .white : .blue)
                        }
                    }
                    
                    Button{
                        withAnimation{
                            showWeek = false
                        }
                    }label:{
                        ZStack{
                            Capsule()
                                .opacity(!showWeek ? 1 : 0)
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 25)
                            Text("all")
                                .foregroundColor(!showWeek ? .white : .blue)
                        }
                    }
                    
                    
                }
                
                CategoryComponent()
                
                if showWeek {
                    CalendarComponent()
                        .frame(height: 125)
                }
                
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                
                List{
                    if showWeek {
                        WeekList(provider: provider, isCompleted: $isCompleted, isOverdue: $isOverdue)
                    } else {
                        TaskList(provider: provider, isCompleted: $isCompleted, isOverdue: $isOverdue)
                    }
                }.ignoresSafeArea()
                    .sheet(isPresented: $showAddTask){
                        AddTaskView()
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Text(Date().formatted(date: .abbreviated, time: .omitted))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: ArchivedListView()){
                                Label("Archive", systemImage: "archivebox")
                            }
                        }
                        ToolbarItem {
                            Button{
                                showAddTask = true
                            }label: {
                                Label("Add", systemImage: "plus")
                            }
                        }
                    }
            }
            .navigationTitle("Today")
        }
    }
    
    func populateMocTasks(){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = "Do Dishes"
        task.taskDescription = "I need to wash last night's dishes."
        task.entryDate = Date()
        task.dueDate = Date()
        task.isDone = false
        task.isArchived = false
    }
    
    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
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

struct TaskList: View {
    var provider = Provider()
    @Binding var isCompleted: Bool
    @Binding var isOverdue: Bool
    
    @StateObject var calendarModel = CalendarViewModel()
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>

    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        ForEach(tasks.filter {(
            !$0.isArchived
            && $0.isDone == isCompleted)
            && !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
        }){ task in
            var taskItem = task
            HStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                    if task.isDone {
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough()
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: TaskList.dateFormatter )")
                            .strikethrough()
                    } else {
                        Text("\(task.title ?? "Unknown")")
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: TaskList.dateFormatter )")
                    }
                    
                    
                }
            }
            .swipeActions(edge: .trailing){
                Button{
                    archiveTask(task: task)
                } label: {
                    Label("Archive", systemImage: "archivebox")
                    
                }.tint(.blue)
            }
            .swipeActions(edge: .leading){
                Button{
                    doneTask(task: task)
                } label: {
                    Label("Done", systemImage: "checkmark")
                }.tint(.blue)
            }
        }
        .onMove(perform: { indices, newOffset in
            provider.moveTask(indices: indices, newOffset: newOffset)
        })
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func calcIsOverdue(dueDate: Date) -> Bool{
        if dueDate > Date(){
            return true
        }else{
            return false
        }
    }
    
    func doneTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
    func addCategory(name: String) {
        let newCat = Category(context: moc)
        newCat.name = name

        try? moc .save()
        print("Saved")
    }
    
}

struct WeekList: View {
    var provider = Provider()
    @Binding var isCompleted: Bool
    @Binding var isOverdue: Bool
    
    @StateObject var calendarModel = CalendarViewModel()
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        ForEach(tasks.filter {(
            !$0.isArchived
            && $0.isDone == isCompleted)
            && !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
            && isSameDay(date1: $0.dueDate ?? Date(), date2: calendarModel.currentDay)
        }){ task in
            var taskItem = task
            HStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough(isCompleted ? true : false)
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: TaskList.dateFormatter )")
                            .strikethrough(isCompleted ? true : false)
 
                    
                    
                }
            }
            .swipeActions(edge: .trailing){
                Button{
                    archiveTask(task: task)
                } label: {
                    Label("Archive", systemImage: "archivebox")
                    
                }.tint(.blue)
            }
            .swipeActions(edge: .leading){
                Button{
                    doneTask(task: task)
                } label: {
                    Label("Done", systemImage: "checkmark")
                }.tint(.blue)
            }
        }
        .onMove(perform: { indices, newOffset in
            provider.moveTask(indices: indices, newOffset: newOffset)
        })
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func calcIsOverdue(dueDate: Date) -> Bool{
        if dueDate > Date(){
            return true
        }else{
            return false
        }
    }
    
    func doneTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
    
//    func addCategory(name: String) {
//        let newCat = Category(context: moc)
//        newCat.name = name
//
//        try? moc .save()
//        print("Saved")
//    }
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}












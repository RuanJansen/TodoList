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
    @State var showWeek = false
    @State var selectedCategory: String = ""
//    var selectedCategoryString: String{
//        CategoryHandler.fetchActiveCategory(moc: moc)?.name ?? "No Category"
//    }
    @State var categoryActive: Bool = false
    @StateObject var calendarModel = CalendarViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    
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
                    
                    
                }
//                categoryActive = ((CategoryHandler.fetchActiveCategory(moc: moc)?.isActive) != nil)
                CategoryComponent(selectedCategory: $selectedCategory, categoryActive: $categoryActive)
                    
                
                if showWeek {
                    CalendarComponent(calendarModel: calendarModel)
                        .frame(height: 125)
                }
                
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                
                List{
                    if showWeek {
                        WeekList(calendarModel: calendarModel, provider: provider, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive).padding()
                    } else {
                        TaskList(provider: provider, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive).padding()
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
//    var dateHandler = DateHandler()
    @Binding var isCompleted: Bool
    @Binding var isOverdue: Bool
    @Binding var selectedCategory: String
    @Binding var categoryActive: Bool
    
    @StateObject var calendarModel = CalendarViewModel()
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>

    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    
    
    var body: some View {
        ForEach(filterTasks()){ task in
            var taskItem = task
            VStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                    VStack(alignment: .leading){
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough(isCompleted ? true : false)
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: DateHandler.dayMonthYearDateFormatter )")
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
                    CompleteTask(task: task)
                } label: {
                    Label("Complete", systemImage: "checkmark")
                }.tint(.yellow)
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
    
    func CompleteTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
    func filterTasks()->[Task] {
        return tasks.filter {
            let notArchive = !$0.isArchived
            let taskIsCompleted = $0.isDone == isCompleted
            let taskIsNotOverdue = !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
            let taskCategory = ($0.category?.name == selectedCategory)
            
            if categoryActive {
                return notArchive
                && taskIsCompleted
                && taskIsNotOverdue
                && taskCategory
            }else{
                return notArchive
                && taskIsCompleted
                && taskIsNotOverdue
            }
        }
    }
    
}

struct WeekList: View {
    @ObservedObject var calendarModel = CalendarViewModel()
    var provider = Provider()

    @Binding var isCompleted: Bool
    @Binding var isOverdue: Bool
    @Binding var selectedCategory: String
    @Binding var categoryActive: Bool
   
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        ForEach(filterTasks()){ task in
            var taskItem = task
            VStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                    VStack(alignment: .leading){
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough(isCompleted ? true : false)
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: DateHandler.dayMonthYearDateFormatter )")
                            .strikethrough(isCompleted ? true : false)
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
                    CompleteTask(task: task)
                } label: {
                    Label("Complete", systemImage: "checkmark")
                }.tint(.yellow)
            }
        }
        .onMove(perform: { indices, newOffset in
            provider.moveTask(indices: indices, newOffset: newOffset)
        })
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let formatter = DateHandler.dayMonthYearDateFormatter        
        let day1 = formatter.string(from: date1)
        let day2 = formatter.string(from: date2)
        
        if day1 == day2 {
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
    
    func CompleteTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
    func filterTasks()->[Task] {
        return tasks.filter {
            let notArchive = !$0.isArchived
            let taskIsCompleted = $0.isDone == isCompleted
            let taskIsNotOverdue = !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
            let taskIsSelectedDay = (isSameDay(date1: $0.dueDate ?? Date(), date2: calendarModel.currentDay))
            let taskCategory = ($0.category?.name == selectedCategory)
            
            if categoryActive {
                return notArchive
                && taskIsCompleted
                && taskIsNotOverdue
                && taskIsSelectedDay
                && taskCategory
            }else{
                return notArchive
                && taskIsCompleted
                && taskIsNotOverdue
                && taskIsSelectedDay
            }
            
            
        }
    }
    
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}












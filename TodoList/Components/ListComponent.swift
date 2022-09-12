//
//  ListComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/11.
//

import SwiftUI

struct ListComponent: View {
    var provider = Provider()
    @Binding var showWeek: Bool
    
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
        
        if showWeek {
            
            DynamicFilteredComponent(dateToFilter: calendarModel.currentDay){ (object: Task) in
                WeekListView(provider: provider, calendarModel: calendarModel, tasks: object, isCompleted: isCompleted, isOverdue: isOverdue)
            }
            
            
        } else {
            AllListView(provider: provider, calendarModel: calendarModel, tasks: tasks, isCompleted: isCompleted, isOverdue: isOverdue)
        }
       
        
    }
    
    func AllListView(provider: Provider, calendarModel: CalendarViewModel, tasks: FetchedResults<Task>, isCompleted: Bool, isOverdue: Bool)->some View{
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
                        Text("\(task.dueDate ?? Date(), formatter: ListComponent.dateFormatter )")
                            .strikethrough()
                    } else {
                        Text("\(task.title ?? "Unknown")")
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: ListComponent.dateFormatter )")
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
    

    
    func WeekListView(provider: Provider, calendarModel: CalendarViewModel, tasks: Task, isCompleted: Bool, isOverdue: Bool)->some View{
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
                    Text("\(task.dueDate ?? Date(), formatter: ListComponent.dateFormatter )")
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
    
//    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
//        let task = Task(context: moc)
//        task.id = UUID()
//        task.title = title
//        task.taskDescription = description
//        task.entryDate = entryDate
//        task.dueDate = dueDate
//        task.isDone = isDone
//        task.isArchived = isArchived
//        try? moc.save()
//    }
    
}

struct ListComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListComponent(showWeek: .constant(true), isCompleted: .constant(false), isOverdue: .constant(false))
    }
}

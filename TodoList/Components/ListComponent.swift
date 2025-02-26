//
//  ListComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/13.
//

import SwiftUI

struct ListComponent: View {
    var provider = Provider()
    @Binding var showWeek: Bool
    @Binding var isArchive: Bool
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
            HStack {
                NavigationLink(destination: TaskView(taskItem: task, title: task.title ?? "Unknown Task", description: task.taskDescription ?? "No description", entryDate: task.entryDate ?? Date(), dueDate: task.dueDate ?? Date())){
                    if task.isDone {
                        Text("\(task.title ?? "Unknown")")
                            .strikethrough()
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: DateHandler.dayMonthYearDateFormatter )")
                            .strikethrough()
                    } else {
                        Text("\(task.title ?? "Unknown")")
                        Spacer()
                        Text("\(task.dueDate ?? Date(), formatter: DateHandler.dayMonthYearDateFormatter )")
                    }
                    
                    
                }
            }
            .swipeActions(edge: .trailing){
                if isArchive{
                    Button{
                        unArchiveTask(task: task)
                    }label: {
                        Label("Unarchive", systemImage: "archivebox.fill")
                    }
                    .tint(.blue)
                }else{
                    Button{
                        archiveTask(task: task)
                    } label: {
                        Label("Archive", systemImage: "archivebox")
                        
                    }.tint(.blue)
                }
                
                
            }
            .swipeActions(edge: .leading){
                if isArchive{
                    Button(role: .destructive){
                        //delete
                    }label: {
                        Label("Delete", systemImage: "trash.fill")
                    }.tint(.red)
                }else{
                    Button{
                        doneTask(task: task)
                    } label: {
                        Label("Done", systemImage: "checkmark")
                    }.tint(.yellow)
                }
                
                
                
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
    
    func unArchiveTask(task: Task){
        task.isArchived = false
        try? moc.save()
    }
    
    func removeTask(indexSet: IndexSet){
        //        $taskItem.remove(atOffsets: indexSet)
    }
    
    func doneTask(task: Task){
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task){
        task.isArchived = true
        try? moc.save()
    }
    
    func filterTasks()->[Task] {
        return tasks.filter {
            let isArchived = $0.isArchived
            let notArchived = !$0.isArchived
            let taskIsCompleted = $0.isDone == isCompleted
            let taskIsNotOverdue = !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
            let taskIsSelectedDay = (isSameDay(date1: $0.dueDate ?? Date(), date2: calendarModel.currentDay))
            let taskCategory = ($0.category?.name == selectedCategory)
            
            if isArchive{
                if categoryActive {
                    return isArchived
                    && taskIsCompleted
                    && taskIsNotOverdue
                    && taskIsSelectedDay
                    && taskCategory
                }else{
                    return isArchived
                    && taskIsCompleted
                    && taskIsNotOverdue
                    && taskIsSelectedDay
                }

            }else{
                if showWeek{
                    if categoryActive {
                        return notArchived
                        && taskIsCompleted
                        && taskIsNotOverdue
                        && taskIsSelectedDay
                        && taskCategory
                    }else{
                        return notArchived
                        && taskIsCompleted
                        && taskIsNotOverdue
                        && taskIsSelectedDay
                    }
                }else{
                    if categoryActive {
                        return notArchived
                        && taskIsCompleted
                        && taskIsNotOverdue
                        && taskCategory
                    }else{
                        return notArchived
                        && taskIsCompleted
                        && taskIsNotOverdue
                    }
                }
            }
            
            
        }
    }
}

//struct ListComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ListComponent()
//    }
//}

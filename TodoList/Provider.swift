//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import Foundation
import SwiftUI

protocol TaskProviding {
    func getTasks() -> [Task]
    func doneTask(task: Task)
    func archiveTask(task: Task)
    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool)
    func moveTask(indices: IndexSet, newOffset: Int)
    func removeTask(indexSet: IndexSet)
    
}

class Provider: TaskProviding {
    @FetchRequest(sortDescriptors: []) private var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) private var moc
    
    init() {
        moc.fetch(<#T##request: NSFetchRequest<NSFetchRequestResult>##NSFetchRequest<NSFetchRequestResult>#>)
    }
    
    func getTasks() -> [Task] {
        return tasks.reversed()
    }
    
    func populateMocTasks() {
        let task = Task(context: moc)
        task.id = UUID()
        task.title = "Do Dishes"
        task.taskDescription = "I need to wash last night's dishes."
        task.entryDate = Date()
        task.dueDate = Date()
        task.isDone = false
        task.isArchived = false
        
    }
    
    func doneTask(task: Task) {
        task.isDone.toggle()
        try? moc.save()
    }
    
    func archiveTask(task: Task) {
        task.isArchived = true
        try? moc.save()
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
    
//    var tasks: [Tasks] = []
//    var tasks = [
//        Tasks(id: 1, title: "Do Dishes", description: "I need to wash last night's dishes.", entryDate: Date(), dueDate: Date(), isDone: false, isArchived: false),
//        Tasks(id: 2, title: "Buy Milk", description: "I need to get milk at spar.", entryDate: Date(), dueDate: Date(), isDone: false, isArchived: true)
//    ]
    
    
//    func addTask(title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
////        print(title)
////        tasks.append(Tasks(id: tasks.count + 1, title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: isDone, isArchived: isArchived))
//    }
    
//    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
//        tasks.append(Tasks(id: tasks.count + 1,title: title, description: description, entryDate: entryDate, dueDate: dueDate, isDone: isDone, isArchived: isArchived))
//    }
    
    func removeTask(indexSet: IndexSet){
//        tasks.remove(atOffsets: indexSet)
    }
    
//    func doneTask(indices: IndexSet){
//        
//    }
//    
//    func archiveTask(indices: IndexSet){
//        
//    }
//    
//    func unArchiveTask(indices: IndexSet){
//        
//    }
    
    func moveTask(indices: IndexSet, newOffset: Int){
//        tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
}

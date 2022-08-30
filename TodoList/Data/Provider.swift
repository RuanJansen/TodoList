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
    func doneTasks(task: Task)
    func archiveTasks(task: Task)
    func moveTask(indexSet: IndexSet, newOffset: Int)
    func removeTask(indexSet: IndexSet)
    func editTask(taskItem: Task, title: String, description: String, dueDate: Date)
    func unArchiveTask(task: Task)
    func addTask(title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool)
}

class Provider {

    @Environment(\.managedObjectContext) var moc
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    func moveTask(indexSet: IndexSet, newOffset: Int) {
//        tasks.move(fromOffsets: indexSet, toOffset: newOffset)
    }
    
//    func getTasks() -> [Task] {
//        return tasks.reversed()
//    }
    
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
//        currentTasks = tasks.reversed().reversed()
    }
    
    func doneTasks(task: Task) {
        task.isDone.toggle()
        try? moc.save()
//        currentTasks = tasks.reversed().reversed()
    }
    
    func archiveTasks(task: Task) {
        task.isArchived = true
        try? moc.save()
//        currentTasks = tasks.reversed().reversed()
    }

    func editTask(taskItem: Task, title: String, description: String, dueDate: Date){
        taskItem.title = title
        taskItem.taskDescription = description
        taskItem.dueDate = dueDate
        try? moc.save()
//        currentTasks = tasks.reversed().reversed()
    }
    
    func removeTask(indexSet: IndexSet){
//        tasks.remove(atOffsets: indexSet)
//            for index in indexSet {
//                let tasks = tasks[index]
//                moc.delete(tasks)
//            }
    }
    
    func unArchiveTask(task: Task){
        task.isArchived = false
        try? moc.save()
//        currentTasks = tasks.reversed().reversed()
    }
}

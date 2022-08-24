//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import Foundation

class TodoListViewController{
//    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    var tasks: [Tasks] = []
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
        tasks.remove(atOffsets: indexSet)
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
        tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
}

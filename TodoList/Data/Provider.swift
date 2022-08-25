//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import Foundation
import SwiftUI

class Provider {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc

    func removeTask(indexSet: IndexSet){
//        tasks.remove(atOffsets: indexSet)
            for index in indexSet {
                let tasks = tasks[index]
                moc.delete(tasks)
            }
    }

    
    func moveTask(indices: IndexSet, newOffset: Int){
//        tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
}

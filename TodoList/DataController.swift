//
//  DataController.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/23.
//
import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "MyTasks")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}

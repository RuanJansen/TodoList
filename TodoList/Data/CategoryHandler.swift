//
//  CategoryHandler.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/13.
//

import Foundation
import CoreData
import SwiftUI

class CategoryHandler: ObservableObject{
    
    class func fetchCategories(moc: NSManagedObjectContext) -> [Category]{
        let fetchRequest = CategoryHandler.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            let results = try moc.fetch(fetchRequest)
            return results
        } catch {
            return []
        }
    }
    
    class func isThereActiveCategory(moc: NSManagedObjectContext)->Bool{
        return fetchActiveCategory(moc: moc) != nil
    }
    
    class func save(moc: NSManagedObjectContext){
        guard moc.hasChanges else { return }
            do {
              try moc.save()
            } catch let error as NSError {
              print("Unresolved error \(error), \(error.userInfo)")
            }
    }
    
    class func fetchActiveCategory(moc: NSManagedObjectContext) -> Category?{
        let categories = fetchCategories(moc: moc)
        let activeCategory = categories.filter{$0.isActive}.first
        return activeCategory
    }
    
    private class func fetchRequest() -> NSFetchRequest<Category>{
        return NSFetchRequest<Category>(entityName: "Category")
        
    }
}

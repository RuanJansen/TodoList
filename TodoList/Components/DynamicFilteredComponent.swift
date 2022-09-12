//
//  DynamicFilteredComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/11.
//

import SwiftUI
import CoreData

struct DynamicFilteredComponent<Content: View, T>: View where T: NSManagedObject {
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content){
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: nil)
        self.content = content
    }
    var body: some View {
        Group{
            if request.isEmpty{
                Text("No tasks found")
            }else{
                ForEach(request,id: \.objectID){ object in
                    self.content(object)
                }
            }
        }
    }
}

//struct DynamicFilteredComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicFilteredComponent()
//    }
//}

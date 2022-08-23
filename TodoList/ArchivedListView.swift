//
//  ArchivedListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ArchivedListView: View {
    let viewController = TodoListViewController()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewController.tasks.filter {$0.isArchived}){ task in
                    HStack {
                        Text("\(task.title)")
                    }
                    .padding()
                    .swipeActions(edge: .leading){
                        Button(role: .destructive){
                            //delete
                        }label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    .swipeActions(edge: .trailing){
                        Button{
                            //unarchive
                        }label: {
                            Label("Unarchive", systemImage: "archivebox.fill")
                        }
                    }.tint(.blue)
                    
                }
            }.navigationTitle("Archived")
        }
    }
}

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}

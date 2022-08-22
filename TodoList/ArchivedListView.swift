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
                ForEach(viewController.tasks, id: \.title){ task in
                    if task.isArchived{
                        HStack {
                          
                            Text("\(task.title)")
                            Spacer()
                            Button{
                                viewController.unArchiveTask()
                            }label: {
                                Label("Unarchive", systemImage: "archivebox")
                            }
                        }.padding()
                    }
                    
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

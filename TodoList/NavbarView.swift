//
//  NavbarView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct NavbarView: View {
    var body: some View {
        TabView{
            TodoListView(taskItem: Tasks(id: 0, title: "", description: "", entryDate: Date(), dueDate: Date(), isDone: false, isArchived: false)).tabItem {
                Label("Tasks", systemImage: "list.bullet")
            }
            AddView().tabItem {
                Label("Add", systemImage: "plus.circle.fill")
            }
        }.accentColor(.green)
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}

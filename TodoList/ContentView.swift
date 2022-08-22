//
//  ContentView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TodoListView(taskItem: Tasks(id: 0, title: "", description: "", entryDate: Date(), dueDate: Date(), isDone: false, isArchived: false))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

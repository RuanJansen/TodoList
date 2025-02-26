//
//  ContentView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = true
    var body: some View {
        TabView {
            TodoListView().tabItem {
                Label("My Taksk", systemImage: "list.bullet")
            }
            
            CompletionSummaryView().tabItem {
                Label("Completion Summary", systemImage: "timelapse")
            }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

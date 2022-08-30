//
//  TodoListApp.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

@main
struct TodoListApp: App {
    @StateObject private var dataController = DataController()
    @State var isActive: Bool = false
    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } else{
                SplashScreenView(isActive: $isActive)
            }
        }
    }
}

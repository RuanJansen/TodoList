//
//  TodoListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct TodoListView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    var provider = Provider()
    @State var showAddTask = false
    @State var isArchive = false
    @State var isCompleted = false
    @State var isOverdue = false
    @State var showWeek = true
    @State var selectedCategory: String = ""
    @State var categoryActive: Bool = false
//    var selectedCategoryString: String{
//        CategoryHandler.fetchActiveCategory(moc: moc)?.name ?? "No Category"
//    }
    
    @StateObject var calendarModel = CalendarViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Button{
                        withAnimation{
                            showWeek = true
                        }
                    }label:{
                        ZStack{
                            Capsule()
                                .opacity(showWeek ? 1 : 0)
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 25)
                            Text("Week")
                                .foregroundColor(showWeek ? .white : .blue)
                        }
                    }
                    
                    Button{
                        withAnimation{
                            showWeek = false
                        }
                    }label:{
                        ZStack{
                            Capsule()
                                .opacity(!showWeek ? 1 : 0)
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 25)
                            Text("all")
                                .foregroundColor(!showWeek ? .white : .blue)
                        }
                    }
                    
                    
                }
//                categoryActive = ((CategoryHandler.fetchActiveCategory(moc: moc)?.isActive) != nil)
                CategoryComponent(selectedCategory: $selectedCategory, categoryActive: $categoryActive)
                    
                
                if showWeek {
                    CalendarComponent(calendarModel: calendarModel)
                        .frame(height: 125)
                }
                
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                
                List{
                    ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive)
                }.ignoresSafeArea()
                    .sheet(isPresented: $showAddTask){
                        AddTaskView()
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Text(Date().formatted(date: .abbreviated, time: .omitted))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: ArchivedListView()){
                                Label("Archive", systemImage: "archivebox")
                            }
                        }
                        ToolbarItem {
                            Button{
                                showAddTask = true
                            }label: {
                                Label("Add", systemImage: "plus")
                            }
                        }
                    }
            }
            .navigationTitle("Today")
        }
    }
    
    func populateMocTasks(){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = "Do Dishes"
        task.taskDescription = "I need to wash last night's dishes."
        task.entryDate = Date()
        task.dueDate = Date()
        task.isDone = false
        task.isArchived = false
    }
    
    func updateTask(indexSet: IndexSet, title: String, description: String, entryDate: Date, dueDate: Date, isDone: Bool, isArchived: Bool){
        let task = Task(context: moc)
        task.id = UUID()
        task.title = title
        task.taskDescription = description
        task.entryDate = entryDate
        task.dueDate = dueDate
        task.isDone = isDone
        task.isArchived = isArchived
        try? moc.save()
    }
}




//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}












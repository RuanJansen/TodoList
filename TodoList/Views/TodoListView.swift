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
    @State var isCompleted = false
    @State var isOverdue = false
    @State var showWeek = true
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
                if showWeek {
                    CalendarComponent()
                        .frame(height: 125)
                }
                
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                
                List{
                    ListComponent(showWeek: $showWeek, isCompleted: $isCompleted, isOverdue: $isOverdue)
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
    
    
}





//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}












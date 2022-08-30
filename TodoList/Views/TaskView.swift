//
//  InfoView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI
import MapKit

struct TaskView: View {
    @State var taskItem: Task
    @State var editMode: Bool = false
    @State var title: String
    @State var description: String
    @State var entryDate: Date
    @State var dueDate: Date
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE HH:mm"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Due Date")) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(taskItem.dueDate ?? Date(), formatter: Self.dateFormatter)
                    }
                    HStack {
                        Text("Time")
                        Spacer()
                        Text(taskItem.dueDate ?? Date(), formatter: Self.timeFormatter)
                    }
                }
                
                Section(header: Text("Entry Date")){
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(taskItem.entryDate ?? Date(), formatter: Self.dateFormatter)
                    }
                    HStack {
                        Text("Time")
                        Spacer()
                        Text(taskItem.entryDate ?? Date(), formatter: Self.timeFormatter)
                    }
                }
                
                Section(header: Text("Description")){
                    Text(taskItem.taskDescription ?? "No description")
                }
                
                Section(header: Text("Location")){
//                    Map(coordinateRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 18, longitude: 33), latitudinalMeters: -2, longitudinalMeters: -2))
                }
                Spacer()
                
            }
        }
        .navigationTitle(taskItem.title ?? "Unknown task").padding()
        .sheet(isPresented: $editMode){
            EditTaskView(taskItem: $taskItem, title: $title, description: $description, dueDate: $dueDate, entryDate: $entryDate)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    editMode.toggle()
                }label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(taskItem: Task())
//    }
//}

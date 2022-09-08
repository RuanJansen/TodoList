//
//  ArchivedListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ArchivedListView: View {
    @State var showAlert: Bool = false
    @State var isCompleted = false
    @State var isOverdue = false
    var body: some View {
            
            VStack {
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                List{
                    ArchivedTaskView(isCompleted: $isCompleted, isOverdue: $isOverdue)
                    
                    
                    
                }
            }
            .navigationTitle("Archived")
            
    }
    
    
    
    
}

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}

struct ArchivedTaskView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    let provider = Provider()
    @Binding var isCompleted: Bool
    @Binding var isOverdue: Bool
    var body: some View {
        ForEach(tasks.filter {
            $0.isArchived
            && $0.isDone == isCompleted
            && !(calcIsOverdue(dueDate: $0.dueDate ?? Date()) == isOverdue)
        }){ task in
            HStack {
                Text("\(task.title ?? "Unknown")")
                    .strikethrough(isCompleted ? true : false)
            }
            .padding()
            .swipeActions(edge: .leading){
                Button(role: .destructive){
                    //delete
                }label: {
                    Label("Delete", systemImage: "trash.fill")
                }.tint(.red)
            }
            .swipeActions(edge: .trailing){
                Button{
                    unArchiveTask(task: task)
                }label: {
                    Label("Unarchive", systemImage: "archivebox.fill")
                }
            }.tint(.blue)
            
        }.onDelete(perform:
                    provider.removeTask
        )
    }
    func calcIsOverdue(dueDate: Date) -> Bool{
        if dueDate > Date(){
            return true
        }else{
            return false
        }
    }
    
    func unArchiveTask(task: Task){
        task.isArchived = false
        try? moc.save()
    }
    
    func removeTask(indexSet: IndexSet){
        //        $taskItem.remove(atOffsets: indexSet)
    }
}

//
//  ArchivedListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ArchivedListView: View {
    let provider = Provider()
    @State var filterDone = true
    @State var filterActive = false
    
    var body: some View {
        NavigationView {
            List{
                Section {
                    ListTask(filterDone: $filterDone)
                }header: {
                    Text("Done")
                }
                Section {
                    ListTask(filterDone: $filterActive)
                }header: {
                    Text("Active")
                }
            }
            .navigationTitle("Archived")
        }
    }
}

struct ListTask: View {
    let provider = Provider()
    @State var showAlert: Bool = false
    @Binding var filterDone: Bool
    var body: some View {
        ForEach(provider.tasks.filter {$0.isArchived && $0.isDone == filterDone}){ task in
            HStack {
                Text("\(task.title ?? "Unknown")")
                    .strikethrough()
            }
            .padding()
            .swipeActions(edge: .leading){
                Button(role: .destructive){
                    //delete
                    showAlert = true
                }label: {
                    Label("Delete", systemImage: "trash.fill")
                }.tint(.red)
                    .alert(isPresented: $showAlert){
                        Alert(
                            title: Text("Are you sure you want to delete this?"),
                            message: Text("There is no undo"),
                            primaryButton: .destructive(Text("Delete")) {
                                print("Deleting...")
                            },
                            secondaryButton: .cancel()
                        )
                    }
            }
            .swipeActions(edge: .trailing){
                Button{
                    provider.unArchiveTask(task: task)
                }label: {
                    Label("Unarchive", systemImage: "archivebox.fill")
                }
            }.tint(.blue)
            
        }.onDelete(perform:
                    provider.removeTask
        )
    }
}

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}

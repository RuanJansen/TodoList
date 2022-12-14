//
//  ArchivedListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ArchivedListView: View {
    let provider = Provider()
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    @State var showAlert: Bool = false
    var body: some View {
        NavigationView {
            List{
                Section {
                    ForEach(tasks.filter {$0.isArchived && $0.isDone}){ task in
                        HStack {
                            Text("\(task.title ?? "Unknown")")
                                .strikethrough()
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
                }header: {
                    Text("Done")
                }
                
                Section {
                    ForEach(tasks.filter {$0.isArchived && !$0.isDone}){ task in
                        HStack {
                            Text("\(task.title ?? "Unknown")")
                        }
                        .padding()
                        .swipeActions(edge: .leading){
                            Button(){
                                //delete
                                showAlert = true
                            }label: {
                                Label("Delete", systemImage: "trash.fill")
                            }.tint(.red)
                                .alert(isPresented: $showAlert){
                                    Alert(
                                        title: Text("Do you want to unalive this task"),
                                        message: Text("There is no undo"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            print("Deleting...")
                                        },
                                        secondaryButton: .cancel())
                                }
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
                }header: {
                    Text("Active")
                }
            }.navigationTitle("Archived")
            
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

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}

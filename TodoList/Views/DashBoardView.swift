//
//  CompletionSummaryView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/05.
//

import SwiftUI

struct DashBoardView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    //Completed
    @State var valueCompleted: Float = 0.0
    @State var totalCompleted: Float = 0.0
    @State var percentageCompleted: Float = 0.0
    @State var progressbarColorCompleted = Gradient(colors: [.white])
    @State var statTypeCompleted: String = ""
    //Overdue
    @State var valueOverdue: Float = 0.0
    @State var totalOverdue: Float = 0.0
    @State var percentageOverdue: Float = 0.0
    @State var progressbarColorOverdue = Gradient(colors: [.white])
    @State var statTypeOverdue: String = ""
    //CompletedArchived
    @State var valueArchived: Float = 0.0
    @State var totalArchived: Float = 0.0
    @State var percentageArchived: Float = 0.0
    @State var progressbarColorArchived = Gradient(colors: [.white])
    @State var statTypeArchived: String = ""
    //Categories
    @Environment(\.managedObjectContext) var moc
    var categories: [Category]{
        return CategoryHandler.fetchCategories(moc: moc)
    }
    @State var navTitle: String = ""
    @State var showView: Bool = false
    @State var isArchive = false
    @State var isCompleted = false
    @State var isOverdue = false
    @State var showWeek = true
    @State var selectedCategory: String = ""
    @State var categoryActive: Bool = false

    var body: some View {
        if tasks.isEmpty{
            Text("No data to show")
        }else{
            NavigationView {
                VStack{
                    ScrollView(.horizontal){
                        HStack{
                            Button{
                                //code
                                navTitle = "All Tasks"
                                showView = true
                                isArchive = false
                                isCompleted = false
                                isOverdue = false
                                showWeek = false
                                selectedCategory = ""
                                categoryActive = false
                            }label:{
                                ProgressbarComponent(statType: $statTypeCompleted, percentage: $percentageCompleted, value: $valueCompleted, total: $totalCompleted, color: $progressbarColorCompleted)
                                    .onAppear(){
                                        let all = tasks.filter {!$0.isArchived}
                                        let total = all.count
                                        let task = all.filter{$0.isDone}.count
                                        let percentage = Float(task)/Float(total)
                                        self.valueCompleted = Float(task)
                                        self.totalCompleted = Float(total)
                                        self.percentageCompleted = percentage
                                        self.progressbarColorCompleted = Gradient(colors: [.green, .mint, .mint, .green])
                                        self.statTypeCompleted = "All Tasks"
                                    }
                            }
                            Button{
                                //code
                                navTitle = "Overdue Tasks"
                                showView = true
                                isArchive = false
                                isCompleted = false
                                isOverdue = true
                                showWeek = false
                                selectedCategory = ""
                                categoryActive = false
                            }label:{
                                ProgressbarComponent(statType: $statTypeOverdue, percentage: $percentageOverdue, value: $valueOverdue, total: $totalOverdue, color: $progressbarColorOverdue)
                                    .onAppear(){
                                        let overdue = tasks.filter{$0.dueDate ?? Date() < Date() && !$0.isArchived}
                                        let total = overdue.count
                                        let task = overdue.filter{$0.isDone}.count
                                        let percentage = Float(task)/Float(total)
                                        self.valueOverdue = Float(task)
                                        self.totalOverdue = Float(total)
                                        self.percentageOverdue = percentage
                                        self.progressbarColorOverdue = Gradient(colors: [.red, .orange, .orange, .red])
                                        self.statTypeOverdue = "Overdue Tasks"
                                    }
                            }
                            Button{
                                //code
                                navTitle = "Archived Tasks"
                                showView = true
                                isArchive = true
                                isCompleted = false
                                isOverdue = false
                                showWeek = false
                                selectedCategory = ""
                                categoryActive = false
                            }label:{
                                ProgressbarComponent(statType: $statTypeArchived, percentage: $percentageArchived, value: $valueArchived, total: $totalArchived, color: $progressbarColorArchived)
                                    .onAppear(){
                                        let overdue = tasks.filter{$0.isArchived}
                                        let total = overdue.count
                                        let task = overdue.filter{$0.isDone}.count
                                        let percentage = Float(task)/Float(total)
                                        self.valueArchived = Float(task)
                                        self.totalArchived = Float(total)
                                        self.percentageArchived = percentage
                                        self.progressbarColorArchived = Gradient(colors: [.blue, .cyan, .cyan, .blue])
                                        self.statTypeArchived = "Archived Tasks"
                                    }
                            }
                        }
                    }
                    Form{
                        Section(header: Text("Categories")){
                            List(categories){ category in
                                Button{
                                    navTitle = category.name ?? "No Categories"
                                    showView = true
                                    isArchive = false
                                    isCompleted = false
                                    isOverdue = false
                                    showWeek = false
                                    selectedCategory = category.name ?? "No Categories"
                                    categoryActive = true
                                }label:{
                                    Text(category.name ?? "No Categories")
                                }
                            }
                        }
                    }
                }.navigationTitle("Completion")
                    .sheet(isPresented: $showView){
                        NavigationView{
                            
                            VStack{
                                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                                List{
                                    ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive).padding()
                                }
                            }.navigationTitle(navTitle)
                        }
                        
                        
                    }
            }
            
        }
//            .navigationTitle("Completion Summary")
    }
}





//struct DashBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletionSummaryView()
//    }
//}

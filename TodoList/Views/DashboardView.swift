//
//  CompletionSummaryView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/05.
//

import SwiftUI

struct DashboardView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
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
    
    
    @State var showWeek: Bool = false
    @State var isArchive: Bool = false
    @State var isCompleted: Bool = false
    @State var isOverdue: Bool = false
    @State var selectedCategory: String = ""
    @State var categoryActive: Bool = false
    
    var categories: [Category]{
        return CategoryHandler.fetchCategories(moc: moc)
    }
    
    var body: some View {
        if tasks.isEmpty{
            Text("No data to show")
        }else{
            NavigationView {
                VStack {
                    Section(header: Text("Charts")) {
                        ScrollView(.horizontal) {
                            HStack {
                                //                        NavigationLink(destination: {
                                //                            VStack {
                                //                                Form {
                                //                                    Section(header: Text(statTypeCompleted)) {
                                //
                                //                                        List{
                                //                                            ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive)
                                //                                        }
                                //                                    }
                                //                                }
                                //                            }
                                //                        })
                                //                        {
                                //                            VStack {
                                //                                ProgressBar(statType: $statTypeCompleted, percentage: $percentageCompleted, value: $valueCompleted, total: $totalCompleted, color: $progressbarColorCompleted)
                                //                                    .onAppear(){
                                //                                        let all = tasks.filter {!$0.isArchived}
                                //                                        let total = all.count
                                //                                        let task = all.filter{$0.isDone}.count
                                //                                        let percentage = Float(task)/Float(total)
                                //                                        self.valueCompleted = Float(task)
                                //                                        self.totalCompleted = Float(total)
                                //                                        self.percentageCompleted = percentage
                                //                                        self.progressbarColorCompleted = Gradient(colors: [.green, .mint, .mint, .green])
                                //                                        self.statTypeCompleted = "All Tasks"
                                //                                    }
                                //
                                //                            }
                                //                        }
                                
                                VStack {
                                    ProgressBar(statType: $statTypeCompleted, percentage: $percentageCompleted, value: $valueCompleted, total: $totalCompleted, color: $progressbarColorCompleted)
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
                                
                                
                                
                                VStack {
                                    ProgressBar(statType: $statTypeOverdue, percentage: $percentageOverdue, value: $valueOverdue, total: $totalOverdue, color: $progressbarColorOverdue)
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
                                
                                VStack {
                                    ProgressBar(statType: $statTypeArchived, percentage: $percentageArchived, value: $valueArchived, total: $totalArchived, color: $progressbarColorArchived)
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
                            .navigationTitle("Completion Summary")
                        }
                    }
                    
//                    Section(header: Text("Categories")){
                        List(categories){ category in
                            NavigationLink(destination: {
                                VStack {
//                                    Form {
//                                        Section(header: Text(selectedCategory)) {
                                            List{
                                                ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory , categoryActive: $categoryActive)
                                                    
                                            }.padding()
//                                        }
//                                    }
                                }.onAppear(){
                                    categoryActive = true
                                    selectedCategory = category.name ?? ""
                                }.navigationTitle(category.name ?? "")
                                
                                
                            }, label: {
                                Text(category.name ?? "")
                            })
                            
                        }
                            
//                            if #available(iOS 16.0, *) {
//                                NavigationStack{
//                                    if #available(iOS 16.0, *) {
//                                        List(categories){ category in
//                                            if #available(iOS 16.0, *) {
//                                                NavigationLink(category.name ?? "", value: category).onAppear(){
//                                                    categoryActive = true
//                                                    selectedCategory = category.name ?? ""
//                                                }
//                                            } else {
//                                                // Fallback on earlier versions
//                                            }
//                                        }.navigationDestination(for: Category.self){ category in
//                                            List{
//                                                ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory , categoryActive: $categoryActive)
//                                            }
//
//                                        }
//                                    } else {
//                                        // Fallback on earlier versions
//                                    }
//                                }
//                            } else {
//                                // Fallback on earlier versions
//                            }
                        }
                    
                }
            }
        }
        
    }


struct ProgressBar: View{
    @Binding var statType: String
    @Binding var percentage: Float
    @Binding var value: Float
    @Binding var total: Float
    @Binding var color: Gradient
    var body: some View{
        ZStack{
            //            RoundedRectangle(cornerRadius: 30)
            //                .opacity(0.1)
            //                .foregroundColor(.white)
            //                .frame(width: 350, height: 350, alignment: .center)
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 250, height: 250, alignment: .center)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.percentage, 1.0)))
            //                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .stroke(
                    AngularGradient(gradient: color,
                                    center: .center),
                    style: StrokeStyle(lineWidth: 15.0,
                                       lineCap: .round, lineJoin: .round))
            //                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
                .frame(width: 250, height: 250, alignment: .center)
            
            VStack(spacing: 10){
                Text(statType)
                    .font(.title3)
                Text(progressBarValue())
                    .font(.title)
                Text("\(Int(value))/\(Int(total))")
                    .font(.title3)
            }
        }
        .padding(30)
    }
    
    func progressBarValue()->String{
        guard !(percentage.isNaN || percentage.isInfinite) else {
            return "No Data to display"
            
        }
        return "\(Int(percentage*100))%"
    }
    
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}

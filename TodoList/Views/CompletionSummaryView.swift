//
//  CompletionSummaryView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/05.
//

import SwiftUI

struct CompletionSummaryView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    //Overdue
    @State var valueOverdue: Float = 0.0
    @State var progressbarColorOverdue = Gradient(colors: [.white])
    @State var sizeOverdue: CGFloat = 0.0
    //Completed
    @State var valueCompleted: Float = 0.0
    @State var progressbarColorCompleted = Gradient(colors: [.white])
    @State var sizeCompleted: CGFloat = 0.0
    var body: some View {
        NavigationView {
            VStack{
                Section {
                    ProgressBar(progress: $valueOverdue, color: $progressbarColorOverdue)
                        .onAppear(){
                            let overdue = tasks.filter{$0.dueDate ?? Date() < Date() && !$0.isArchived}
                            let totalOverdue = overdue.count
                            let overdueTasks = overdue.filter{$0.isDone}.count
                            let percentage = Float(overdueTasks)/Float(totalOverdue)
                            print("Overdue \(percentage)")
                            self.valueOverdue = percentage
//                            self.progressbarColorOverdue = Color.red
                            self.sizeOverdue = 200.0
                            self.progressbarColorOverdue = Gradient(colors: [.red, .pink, .orange, .pink, .red])
                        }
                }header: {
                    Text("Overdue Tasks Completed")
                }
                .padding()
                Spacer()
                Section {
                    ProgressBar(progress: $valueCompleted, color: $progressbarColorCompleted)
                        .onAppear(){
                            let all = tasks.filter {!$0.isArchived}
                            let totalCompleted = all.count
                            let completed = all.filter{$0.isDone}.count
                            let percentage = Float(completed)/Float(totalCompleted)
                            print("Completed \(percentage)")
                            self.valueCompleted = percentage
//                            self.progressbarColorCompleted = Color.green
                            self.sizeCompleted = 250.0
                            self.progressbarColorCompleted = Gradient(colors: [.blue, .cyan, .purple, .cyan, .blue])
                        }
                }header: {
                    Text("All Tasks Completed")
                }
                .padding()
            }
            .navigationTitle("Completion Summary")
        }
            
    }
}

struct ProgressBar: View{
    @Binding var progress: Float
    @Binding var color: Gradient
    var body: some View{
        ZStack{
//            Rectangle()
//                .opacity(0)
//                .background(.ultraThinMaterial)
//                    .cornerRadius(30)
//                    .frame(width: 250, height: 250, alignment: .center)
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 200, height: 200, alignment: .center)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
//                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .stroke(
                    AngularGradient(gradient: color,
                    center: .center),
                    style: StrokeStyle(lineWidth: 15.0,
                    lineCap: .round, lineJoin: .round))
//                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
                .frame(width: 200, height: 200, alignment: .center)
            
            Text("\(Int(progress*100))%")
                .font(.title)
        }
    }
}

//struct CompletionSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletionSummaryView()
//    }
//}

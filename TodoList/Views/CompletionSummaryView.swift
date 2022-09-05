//
//  CompletionSummaryView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/05.
//

import SwiftUI

struct CompletionSummaryView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    @State var completedTasks: Float = 0.0
    @State var completedOverdueTasks: Float = 0.0
    @State var allTasksColor: Color = Color.green
    @State var overdueTasksColor: Color = Color.red
    var body: some View {
        VStack{
            Section {
                ProgressBar(progress: $completedOverdueTasks, color: $overdueTasksColor)
                    .padding()
                    .onAppear(){
                        let overdue = tasks.filter{$0.dueDate ?? Date() < Date() && !$0.isArchived}
                        let totalOverdue = overdue.count
                        let overdueTasks = overdue.filter{$0.isDone}.count
                        let percentage = Float(overdueTasks)/Float(totalOverdue)
                        print("Overdue \(percentage)")
                        self.completedOverdueTasks = percentage
                    }
            }header: {
                Text("Overdue Tasks Completed")
            }
            Spacer()
            Section {
                ProgressBar(progress: $completedTasks, color: $allTasksColor)
                    .padding()
                    .onAppear(){
                        let all = tasks.filter {!$0.isArchived}
                        let totalCompleted = all.count
                        let completed = all.filter{$0.isDone}.count
                        let percentage = Float(completed)/Float(totalCompleted)
                        print("Completed \(percentage)")
                        self.completedTasks = percentage
                    }
            }header: {
                Text("All Tasks Completed")
            }
        }.padding()
    }
}

struct ProgressBar: View{
    @Binding var progress: Float
    @Binding var color: Color
    var body: some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 250, height: 250, alignment: .center)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
                .frame(width: 250, height: 250, alignment: .center)
            
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

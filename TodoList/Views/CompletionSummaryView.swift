//
//  CompletionSummaryView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/05.
//

import SwiftUI

struct CompletionSummaryView: View {
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
                            self.completedOverdueTasks = 0.25
                        }
                }header: {
                    Text("Overdue Tasks")
                }
                Spacer()
                Section {
                    ProgressBar(progress: $completedTasks, color: $allTasksColor)
                        .padding()
                        .onAppear(){
                            self.completedTasks = 0.75
                        }
                }header: {
                    Text("Completed Tasks")
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

struct CompletionSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionSummaryView()
    }
}

//
//  FilterComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/08.
//

import SwiftUI

struct FilterComponent: View {
    @Binding var isOverdue: Bool
    @Binding var isCompleted: Bool
    var body: some View {
        HStack{
            Button{
                isOverdue.toggle()
            }label:{
                ZStack{
                    Capsule()
                        .opacity(isOverdue ? 1 : 0)
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 25)
                    Text("Overdue")
                        .foregroundColor(isOverdue ? .white : .blue)
                }
            }
            Spacer()
            Button{
                isCompleted.toggle()
            }label:{
                ZStack{
                    Capsule()
                        .opacity(isCompleted ? 1 : 0)
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 25)
                    Text("Completed")
                        .foregroundColor(isCompleted ? .white : .blue)
                }
            }
            
        }.padding()
    }
}


struct FilterComponent_Previews: PreviewProvider {
    static var previews: some View {
        FilterComponent(isOverdue: .constant(false), isCompleted: .constant(false))
    }
}

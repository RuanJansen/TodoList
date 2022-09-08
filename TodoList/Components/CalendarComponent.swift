//
//  CalendarComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/08.
//

import SwiftUI

struct CalendarComponent: View {
    @StateObject var calendarModel = CalendarViewModel()
    @Namespace var animation
    var body: some View {
        VStack{
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                Section {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(calendarModel.currentWeek, id: \.self){ day in
                                Button{
                                    
                                }label:{
                                    
                                    ZStack {
                                        Capsule()
                                            .opacity(calendarModel.isToday(date: day) ? 1 : 0)
                                            .foregroundColor(.blue)
                                        VStack(spacing: 10 ) {
                                            Text(calendarModel.extractDate(date: day, format: "dd"))
                                            
                                            Text(calendarModel.extractDate(date: day, format: "EEE"))
                                            
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 10, height: 10, alignment: .center)
                                                .opacity(calendarModel.isToday(date: day) ? 1 : 0)
                                                
                                        }
                                        .foregroundColor(calendarModel.isToday(date: day) ? .white : .blue)
                                        .foregroundStyle(calendarModel.isToday(date: day) ? .primary : .secondary)
                                        
                                        .font(.system(size: 15))
                                        
                                    }
                                    .frame(width: 45, height: 90, alignment: .center)
                                    .foregroundColor(calendarModel.isToday(date: day) ? .blue : .white)
                                    .background(
                                        ZStack{
                                            if calendarModel.isToday(date: day){
                                                Capsule()
                                                    .fill(.blue)
                                                    .opacity(0.5)
//                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
//                                    .contentShape(Capsule())
                                    .onTapGesture {
//                                        withAnimation{
                                            calendarModel.currentDay = day
                                        print(calendarModel.currentDay)
//                                        }
                                    }
                                }
                                
                                
                            }
                        }
                    }
                } 
            }
        }
    }
    // MARK: Header
    func HeaderView()->some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted))
//                Text("Today")
                    .font(.title)
            }
            .hLeading()
            //            Spacer()
        }
    }
    
}

struct CalendarComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarComponent()
    }
}

// MARK: UI Design helper functions
extension View{    
    func hLeading()->some View{
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View{
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View{
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}

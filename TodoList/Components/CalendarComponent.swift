//
//  CalendarComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/08.
//

import SwiftUI

struct CalendarComponent: View {
    @StateObject var calendarModel = CalendarViewModel()
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
                                            .frame(width: 50, height: 100, alignment: .center)
                                        VStack(spacing: 10 ) {
                                            Text(calendarModel.extractDate(date: day, format: "dd"))
                                            
                                            Text(calendarModel.extractDate(date: day, format: "EEE"))
                                            
                                                
                                        }.foregroundColor(.white)
                                        
                                    }
                                }
                                
                                
                            }
                        }
                    }
                } 
            }
        }.padding(.horizontal)
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

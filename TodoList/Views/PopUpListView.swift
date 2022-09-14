//
//  PopUpListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/14.
//

import SwiftUI

struct PopUpListView: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var isOverdue: Bool
    @Binding var isCompleted: Bool
    @Binding var showWeek: Bool
    @Binding var isArchive: Bool
    @Binding var selectedCategory: String
    @Binding var categoryActive: Bool
    @Binding var navTitle: String
    var body: some View {
        NavigationView{
            VStack{
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                List{
                    ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive).padding()
                }
            }.navigationTitle(navTitle)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            Text("Close")
                        }
                    }
                }
        }
    }
}

//struct PopUpListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpListView()
//    }
//}

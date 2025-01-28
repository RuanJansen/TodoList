//
//  ArchivedListView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/22.
//

import SwiftUI

struct ArchivedListView: View {
    @State var showAlert: Bool = false
    @State var isArchive = true
    @State var isCompleted = false
    @State var isOverdue = false
    @State var showWeek = false
    @State var selectedCategory: String = ""
    @State var categoryActive: Bool = false
    var body: some View {
            VStack {
                FilterComponent(isOverdue: $isOverdue, isCompleted: $isCompleted)
                List{
                    ListComponent(showWeek: $showWeek, isArchive: $isArchive, isCompleted: $isCompleted, isOverdue: $isOverdue, selectedCategory: $selectedCategory, categoryActive: $categoryActive)
                }
            }
            .navigationTitle("Archived")
    }
}

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}

//
//  CategoryView.swift
//  TodoList
//
//  Created by Sibusiso Mbonani on 2022/09/06.
//

import SwiftUI

struct CategoryView: View {
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc
    
    @State var category: Category
    @State var showAddCategory = false
    @State var title: String
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    List(categories) { category in
                        Text(category.name ?? "Unknown")
                        
                    }
                }
            }
        }
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}

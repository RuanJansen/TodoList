//
//  CategoryView.swift
//  TodoList
//
//  Created by Sibusiso Mbonani on 2022/09/06.
//

import SwiftUI

struct CategoryView: View {
//    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
//    @Environment(\.managedObjectContext) var moc
//
//    @State var category: Category
//    @State var showAddCategory = false
//    @State var title: String
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    List(categories) { category in
//                        Text(category.name ?? "Unknown")
//
//                    }
//                }
//            }
//        }
//    }
    
        @State var categories = ["work", "etertainment", "school"]
        @State var showAddCategory = false
        @State var title: String = ""
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories, id:\.self) {category in
                        Button{
                            //code
                        }label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 115, height: 25, alignment: .center)
                                    .foregroundColor(.blue)
                                Text(category)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }.padding()
            }
        }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

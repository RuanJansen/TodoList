//
//  CategoryComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/12.
//

import SwiftUI

struct CategoryComponent: View {
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @State var selectedCategory: String = ""
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(categories){ category in
                    Button{
                        selectedCategory = category.name ?? "No Category"
                    }label: {
                        ZStack{
                            Capsule()
                                .frame(width: 100, height: 25, alignment: .center)
                                .foregroundColor(category.name == selectedCategory ? .blue : .white)
                                .opacity(category.name == selectedCategory ? 1 : 0)
                            Text(category.name ?? "No Category")
                                .foregroundColor(category.name == selectedCategory ? .white : .blue)
                        }
                    }
                    
                }
            }
        }.frame(height: 50)
    }
}

struct CategoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        CategoryComponent()
    }
}

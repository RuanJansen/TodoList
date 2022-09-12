//
//  CategoryComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/12.
//

import SwiftUI

struct CategoryComponent: View {
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Binding var selectedCategory: String
    @Binding var categoryActive: Bool
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 25){
                ForEach(categories){ category in
                    Button{
                        categoryActive.toggle()
                        selectedCategory = category.name ?? "No Category"
                    }label: {
                        ZStack{
                            Capsule()
                                .frame(width: 125, height: 25, alignment: .center)
                                .foregroundColor(categoryActive && category.name == selectedCategory ? .blue : .white)
                                .opacity(categoryActive && category.name == selectedCategory ? 1 : 0)
                            Text(category.name ?? "No Category")
                                .foregroundColor(categoryActive && category.name == selectedCategory ? .white : .blue)
                        }
                    }
                    
                }
            }.padding()
        }.frame(height: 50)
    }
}

//struct CategoryComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryComponent(selectedCategory: "", categoryActive: .constant(false))
//    }
//}

//
//  CategoryComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/12.
//

import SwiftUI

struct CategoryComponent: View {
//    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc
    var categories: [Category]{
        return CategoryHandler.fetchCategories(moc: moc)
    }
    @State var toggle: Bool = false
    @Binding var selectedCategory: String
    @Binding var categoryActive: Bool
    
    var body: some View {
        let activeCategory = CategoryHandler.fetchActiveCategory(moc: moc)
//        categoryActive = CategoryHandler.isThereActiveCategory(moc: moc)
//        categoryActive = activeCategory != nil
//        categoryActive = (activeCategory?.isActive ?? false)
//        setUpInitState()
        ScrollView(.horizontal){
            HStack(spacing: 25){
                ForEach(categories){ category in
//                    categoryActive = activeCategory?.isActive ?? false
//                    if let currentCategory = activeCategory{
//                        categoryActive = true
//                    } else {
//                        categoryActive = false
//                    }
                    
                    
//                    let shouldUpdateStyle = (activeCategory == category) && (toggle != nil) && (categoryActive)
                    Button{
                        
                        if activeCategory == category{
                            updateActiveCategory(with: category)
                        }else{
                            updateSelectedCategory(with: category)
                        }
                        toggle = !toggle
                    }label: {
                        ZStack{
                            Capsule()
                                .frame(width: 125, height: 25, alignment: .center)
                                .foregroundColor((activeCategory == category) && (toggle != nil) && (categoryActive) ? .blue : .white)
                                .opacity((activeCategory == category) && (toggle != nil) && (categoryActive) ? 1 : 0)
                            Text(category.name ?? "No Category")
                                .foregroundColor((activeCategory == category) && (toggle != nil) && (categoryActive) ? .white : .blue)
                        }
                    }
                    
                }
            }
            .padding()
        }.frame(height: 50)
    }
    
    private func setUpInitState(){
        let activeCategory = CategoryHandler.fetchActiveCategory(moc: moc)
        categoryActive = activeCategory != nil
        
    }
    
    private func updateSelectedCategory(with category: Category){
        let activeCategory = CategoryHandler.fetchActiveCategory(moc: moc)

        activeCategory?.isActive = false
        category.isActive = true
        categoryActive = true
        selectedCategory = category.name ?? ""
        CategoryHandler.save(moc: moc)
    }
    
    private func updateActiveCategory(with category: Category){
        category.isActive = !category.isActive
        categoryActive = category.isActive
        selectedCategory = category.isActive ? (category.name ?? "") : ""
//        activeCategory?.isActive = false
        
        CategoryHandler.save(moc: moc)
        
    }
    
}

//struct CategoryComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryComponent(selectedCategory: "", categoryActive: .constant(false))
//    }
//}

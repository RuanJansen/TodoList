//
//  TextFieldAlertComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/12.
//

import SwiftUI


struct TextFieldAlertComponent<Presenting>: View where Presenting: View {
    @FetchRequest(sortDescriptors: []) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var moc

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                        .font(.title3)
                    TextField("", text: self.$text)
                    Divider()
                    VStack {
                        Button{
                            withAnimation {
                                addCategory(name: text)
                                self.isShowing = false
                            }
                        }label: {
                            Text("Add")
                        }
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.isShowing = false
                            }
                        }) {
                            Text("Cancel")
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .frame(
//                    width: deviceSize.size.width*0.7,
//                    height: deviceSize.size.height*0.7
                    width: 250, height: 150, alignment: .center
                )
                .cornerRadius(30)
//                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
    
    func addCategory(name: String) {
        let newCat = Category(context: moc)
        newCat.name = name
        newCat.isActive = false
        try? moc .save()
        print("Saved")
    }

}



//struct TextFieldAlertComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldAlertComponent()
//    }
//}

//
//  SplashScreenView.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/08/30.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State var size: Double = 0.8
    @State var opacity: Double = 0.5
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "list.bullet")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                Text("To Do list")
                    .padding()
                    .foregroundColor(.blue)
            }.scaleEffect(size)
                .opacity(opacity)
                .onAppear(){
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                self.isActive = true
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(true))
    }
}

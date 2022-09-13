//
//  ProgressbarComponent.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/13.
//

import SwiftUI


struct ProgressbarComponent: View{
    @Binding var statType: String
    @Binding var percentage: Float
    @Binding var value: Float
    @Binding var total: Float
    @Binding var color: Gradient
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .opacity(0.1)
                .foregroundColor(.white)
                .frame(width: 350, height: 350, alignment: .center)
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 250, height: 250, alignment: .center)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.percentage, 1.0)))
            //                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .stroke(
                    AngularGradient(gradient: color,
                                    center: .center),
                    style: StrokeStyle(lineWidth: 15.0,
                                       lineCap: .round, lineJoin: .round))
            //                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
                .frame(width: 250, height: 250, alignment: .center)
            
            VStack(spacing: 10){
                Text(statType)
                    .font(.title3)
                Text(progressBarValue())
                    .font(.title)
                Text("\(Int(value))/\(Int(total))")
                    .font(.title3)
            }
        }
        .padding()
    }
    
    func progressBarValue()->String{
        guard !(percentage.isNaN || percentage.isInfinite) else {
            return "No Data to display"
            
        }
        return "\(Int(percentage*100))%"
    }
}
    

//
//struct ProgressbarComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressbarComponent()
//    }
//}

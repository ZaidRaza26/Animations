//
//  ContentView.swift
//  Animations
//
//  Created by Zaid Raza on 10/09/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isRectangle = false
    @State private var enabled = false
    
    @State private var animationAmount: CGFloat = 1
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        VStack{
            Button("Tap Me") {
                self.enabled.toggle()
            }
            .padding(50)
            .background(enabled ? Color.red : Color.blue)
            .animation(.default)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged{self.dragAmount = $0.translation}
            )
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(Double(animationAmount)), axis: (x: 0, y: 1, z: 0))
            
            Button("Tap me"){
                withAnimation{self.isRectangle.toggle()}
            }
            
            if isRectangle{
                Rectangle()
                    .fill(Color.red)
                    .frame(width:300, height: 200)
                    .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .transition(.pivot)
            }
        }
    }
}


struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

//
//  StatisticsChoiceView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI
import Combine

struct StatisticsChoiceView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.system(size: 33))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
            Spacer()
            HStack( spacing: 40){
                Image(leftImageName)
                    .colorMultiply(leftImageColorMultiply)
                    .ifTrue(animationType == .rotation) {
                        $0.rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                            .animation(self.isAnimating ? self.endlessAnimation : self.endingAnimation)
                            .onAppear {
                                self.isAnimating = true
                        }
                }.ifTrue(animationType == .fadingToAnotherImage){
                    $0.opacity(fadeOut ? 0 : 1)
                        .animation(.easeInOut(duration: 0.10))
                }
                Image(rightImageName)
                    .colorMultiply(rightImageColorMultiply)
                    .ifTrue(animationType == .rotation) {
                        $0.rotationEffect(Angle(degrees: self.isAnimating ? -360.0 : 0.0))
                            .animation(self.isAnimating ? self.endlessAnimation : self.endingAnimation)
                }.ifTrue(animationType == .fadingToAnotherImage){
                    $0.opacity(fadeOut ? 0 : 1)
                        .animation(.easeInOut(duration: 0.10))
                }
            }
            .padding(5)
        }
        .frame(width: bounds.width * 0.9, height: min (200, bounds.height * 0.3))
        .ifTrue(animationType == .fadingToAnotherImage){
            $0.onReceive(timer, perform: {_ in
                self.fadeOut.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                    withAnimation {
                        self.swapLeftAndRightImageName()    // 2) change image
                        self.fadeOut.toggle()         // 3) fade in
                    }
                }
            })
        }
        
    }
    
    private var bounds: CGRect { UIScreen.main.bounds }
    var text: String
    @State var leftImageName: String
    @State var rightImageName: String
    var leftImageColorMultiply: Color
    var rightImageColorMultiply: Color
    @State var animationType: StatisticsChoiceViewAnimationType
    @State private var isAnimating = false
    @State private var fadeOut = false
    
    let timer = Timer.publish(every: 2.5, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    var endlessAnimation: Animation {
        let duration: Double = animationType == .rotation  ? 6.0 : 1.0
        return Animation.linear(duration: duration)
            .repeatForever(autoreverses: false)
    }
    
    var endingAnimation: Animation {
        let duration: Double = animationType == .rotation  ? 6.0 : 1.0
        return Animation.linear(duration: duration)
    }
    
    func swapLeftAndRightImageName() {
        let leftName = leftImageName
        let rightName = rightImageName
        self.leftImageName = rightName
        self.rightImageName = leftName
    }
}

struct StatisticsChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsChoiceView(text: "Hello World", leftImageName: "corona", rightImageName: "corona", leftImageColorMultiply: Color(.white), rightImageColorMultiply: Color(.green), animationType: .rotation)
            .previewLayout(.sizeThatFits)
    }
}

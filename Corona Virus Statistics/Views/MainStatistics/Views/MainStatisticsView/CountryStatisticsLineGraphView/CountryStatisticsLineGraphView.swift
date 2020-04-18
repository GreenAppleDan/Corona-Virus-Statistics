//
//  CountryStatisticsLineGraphView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryStatisticsLineGraphView: View {
    @EnvironmentObject var viewModel: CountryChoiceViewModel
    @State var on = false
    
    var body: some View {
        VStack {
            CountryStatisticsLineGraphShape(viewModel: viewModel)
                .trim(to: on ? 1 : 0)
                .stroke(LinearGradient(gradient: Gradient(colors: ColorStorage.brandGradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                //.aspectRatio(16/9, contentMode: .fit)
                .border(Color.white, width: 3)
                .padding()
            
            //            Button("Animate") {
            //                withAnimation(.easeInOut(duration: 2)) {
            //                    self.on.toggle()
            //                }
            //            }
        }.onAppear(perform: {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2)) {
                    self.on.toggle()
                }
            }
            
        })
    }
}


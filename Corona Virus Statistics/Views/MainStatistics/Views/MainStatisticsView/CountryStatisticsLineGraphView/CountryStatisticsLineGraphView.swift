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
    
    var body: some View {
        VStack {
            Text("COVID-19 Progression for \(viewModel.chosenCountry.name)")
                .font(.system(size: 33, weight: .semibold, design: .default))
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 60, trailing: 40))
            
            CountryStatisticsLineGraphShape(viewModel: viewModel)
                //.trim(to: on ? 1 : 0)
//                .stroke(LinearGradient(gradient: Gradient(colors: ColorStorage.brandGradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                //.aspectRatio(16/9, contentMode: .fit)
                .border(Color.white, width: 3)
                .padding()
            
            //            Button("Animate") {
            //                withAnimation(.easeInOut(duration: 2)) {
            //                    self.on.toggle()
            //                }
            //            }
        }
    }
}


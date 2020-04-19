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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("COVID-19 Progression for \(viewModel.chosenCountry.name)")
                .multilineTextAlignment(.center)
                .font(.system(size: 33, weight: .semibold, design: .default))
                .padding()
            
            VStack {
                
                HStack {
                    Text(String(viewModel.getMaxCasesDaysForCountryStatistics()))
                        .padding(EdgeInsets(top: 15, leading: 50, bottom: -5, trailing: 15))
                    Spacer()
                }
                
                HStack {
                    
                    VStack {
                        Spacer()
                        Text(viewModel.virusDailyCountryStatistics.first?.date?.getFormattedBasicString() ?? "")
                        .foregroundColor(ColorStorage.brightOrange)
                        .rotationEffect(.degrees(-90))
                        .font(.system(size: 8, design: .default))
                    }
                    CountryStatisticsLineGraphShape()
                        .border(colorScheme == .dark ? Color.white : Color.black, width: 3)
                        .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: -15))
                        .environmentObject(viewModel)
                    
                    VStack {
                        Text(viewModel.virusDailyCountryStatistics.last?.date?.getFormattedBasicString() ?? "")
                        .foregroundColor(ColorStorage.brightOrange)
                        .rotationEffect(.degrees(-90))
                        .font(.system(size: 8, design: .default))

                        Spacer()
                        
                        
                        
                    }//.padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                }
                
                HStack {
                    Text(String(0))
                        .padding(EdgeInsets(top: 0, leading: 65, bottom: 10, trailing: 15))
                    Spacer()
                }
            }
        }
    }
}


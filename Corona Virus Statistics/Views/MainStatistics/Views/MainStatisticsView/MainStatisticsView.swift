//
//  MainStatisticsView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI
import Combine

struct MainStatisticsView: View {
    var body: some View {
        VStack(spacing: 25) {
            Text("COVID-19 Statistics")
                .font(.system(size: 33, weight: .semibold, design: .default))
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 60, trailing: 40))
            Button(action: {
                self.viewModel.fetchOverallVirusCases()
                self.presentOverallCases = true
            }) {
                StatisticsChoiceView(text: "Worldwide statistics", leftImageName: "corona", rightImageName: "corona", leftImageColorMultiply: .white, rightImageColorMultiply: .green, animationType: .rotation)
                    .background(RoundedCornersView(color: Color(red: 173/255 , green: 230/255, blue: 230/255, opacity: 0.7), tl: 0, tr: 60, bl: 20, br: 0))
                    .modifier(CustomShadow(shadowRadius: 3))
            }.buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $presentOverallCases) {
                    WorldwideStatisticsView()
                        .environmentObject(self.viewModel)
            }
            
            Button(action: {
                self.presentCountrySearchList = true
            }) {
                StatisticsChoiceView(text: "Specific country statistics", leftImageName: "planet1", rightImageName: "planet2", leftImageColorMultiply: .white, rightImageColorMultiply: .white, animationType: .fadingToAnotherImage)
                    .background(RoundedCornersView(color: Color(red: 173/255 , green: 230/255, blue: 230/255, opacity: 0.7), tl: 60, tr: 0, bl: 0, br: 20))
                    .modifier(CustomShadow(shadowRadius: 3))
            }.buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $presentCountrySearchList) {
                    CountryChoiceView(countries: self.$viewModel.countries)
                        .environmentObject(self.viewModel)
            }
            
            Spacer()
        }
    }
    
    @ObservedObject private var viewModel = MainStatisticsViewModel()
    @State private var presentOverallCases: Bool = false
    @State private var presentCountrySearchList: Bool = false
    
}

struct MainStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        MainStatisticsView()
        
    }
}

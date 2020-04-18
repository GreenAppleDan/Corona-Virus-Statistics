//
//  CountryStatisticsView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryStatisticsView: View {
    @EnvironmentObject var viewModel: CountryChoiceViewModel
    
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Statistics for \(viewModel.chosenCountry.name)")
                .frame( alignment: .center)
                .font(.system(size: 33, weight: .semibold, design: .default))
            
            Spacer()
            
            StatisticsTextView(text: "Total confirmed cases: \(totalConfirmedCases)")
                .cornerRadius(12)
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
            
            StatisticsTextView(text: "Total deaths:  \(totalDeaths)")
                .cornerRadius(12)
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
            
            StatisticsTextView(text: "Total recovered:  \(totalRecovered)")
                .cornerRadius(12)
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
            
            StatisticsTextView(text: "Currently ill:  \(currentlyIll)")
                .cornerRadius(12)
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
            
            Spacer()
        }.onAppear(perform: {
            self.viewModel.fetchLatestStatisticsFor(countryName: self.viewModel.chosenCountry.name) {
                if let confirmed = self.viewModel.virusCountryStatistics.Confirmed, let totalDeaths = self.viewModel.virusCountryStatistics.Deaths, let totalRecovered = self.viewModel.virusCountryStatistics.Recovered {
                    self.totalConfirmedCases = String(confirmed)
                    self.totalDeaths = String(totalDeaths)
                    self.totalRecovered = String(totalRecovered)
                    self.currentlyIll = String(confirmed - totalDeaths - totalRecovered)
                } else {
                    self.totalConfirmedCases = "N/A"
                    self.totalDeaths = "N/A"
                    self.totalRecovered = "N/A"
                    self.currentlyIll = "N/A"
                }
                
            }
            
        })
        
    }
    @State private var totalConfirmedCases: String = "Loading..."
    
    @State private var totalDeaths: String = "Loading..."
    
    @State private var totalRecovered: String = "Loading..."
    
    @State private var currentlyIll: String = "Loading..."
}

struct CountryStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatisticsView()
    }
}

//
//  WorldwideStatisticsView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct WorldwideStatisticsView: View {
    @EnvironmentObject var viewModel: MainStatisticsViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Worldwide statistics")
                .frame( alignment: .leading)
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
        }
    }
    
    var totalConfirmedCases: String {
        guard let totalConfirmed = viewModel.overallStatistics.TotalConfirmed else { return "Loading..."}
        return String(totalConfirmed)
    }
    
    var totalDeaths: String {
        guard let totalDeaths = viewModel.overallStatistics.TotalDeaths else { return "Loading..."}
        return String(totalDeaths)
    }
    
    var totalRecovered: String {
        guard let totalRecovered = viewModel.overallStatistics.TotalRecovered else { return "Loading..."}
        return String(totalRecovered)
    }
    
    var currentlyIll: String {
        guard let totalConfirmed = viewModel.overallStatistics.TotalConfirmed, let totalDeaths = viewModel.overallStatistics.TotalDeaths, let totalRecovered = viewModel.overallStatistics.TotalRecovered else { return "Loading..." }
        return String(totalConfirmed - totalDeaths - totalRecovered)
    }
}

struct WorldwideStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        WorldwideStatisticsView()
    }
}

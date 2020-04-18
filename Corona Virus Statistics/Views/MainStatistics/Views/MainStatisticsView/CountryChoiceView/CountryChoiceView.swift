//
//  CountryChoiceView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI
import Combine
struct CountryChoiceView: View {
    @Binding var countries: [Country]
    @State private var presentCountryStatistics: Bool = false
    @ObservedObject private var viewModel = CountryChoiceViewModel()
    
    var body: some View {
        VStack {
            CountryChoiceSearchView(viewModel: viewModel)
            List {
                ForEach(countries.sorted(by: { $0.name < $1.name }).filter{
                    guard !viewModel.searchText.isEmpty else { return true }
                    return $0.name.contains(viewModel.searchText)}, id: \.name){ country in
                        Button(action: {
                            self.viewModel.fetchLatestStatisticsFor(countryName: country.slug)
                            self.viewModel.chosenCountryName = country.name
                            self.presentCountryStatistics = true
                        }) {
                            CountryChoiceListView(text: country.name)
                        }
                }
            }.sheet(isPresented: $presentCountryStatistics) {
                CountryStatisticsView()
                    .environmentObject(self.viewModel)
            }
        }
    }
}


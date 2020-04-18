//
//  CountryChoiceView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryChoiceView: View {
    @EnvironmentObject var viewModel: MainStatisticsViewModel
    @State private var presentCountryStatistics: Bool = false
    var body: some View {
        VStack {
            CountryChoiceSearchView(viewModel: viewModel)
            List {
                ForEach(viewModel.countries.filter{
                    guard !viewModel.searchText.isEmpty else { return true }
                    return $0.name.contains(viewModel.searchText)}, id: \.name){ country in
                        Button(action: {
                            self.viewModel.virusCountryStatistics = VirusCountryStatistics()
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

struct CountryChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CountryChoiceView()
    }
}

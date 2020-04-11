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
    @Binding var amIShown: Bool
    @Binding var presentCountryStatistics: Bool
    var body: some View {
        VStack {
            CountryChoiceSearchView(viewModel: viewModel)
            List {
                ForEach(viewModel.countries.filter{
                    guard !viewModel.searchText.isEmpty else { return true }
                    return $0.name.contains(viewModel.searchText)}, id: \.name){ country in
                        Button(action: {
                            self.viewModel.virusCountryStatistics = VirusCountryStatistics()
                            self.viewModel.fetchLatestStatisticsFor(countryName: country.name)
                            self.viewModel.chosenCountryName = country.name
                            self.amIShown = false
                            self.presentCountryStatistics = true
                        }) {
                            CountryChoiceListView(text: country.name)
                        }
                }
            }
        }
    }
}

struct CountryChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CountryChoiceView(amIShown: .constant(true), presentCountryStatistics: .constant(true))
    }
}

//
//  CountryChoiceSearchView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryChoiceSearchView: View {
    @ObservedObject var viewModel: CountryChoiceViewModel
    var body: some View {
        HStack {
            TextField("Enter Country", text: $viewModel.searchText)
                .padding(5)
            Image("search")
            .resizable()
                .frame(width: 24, height: 24, alignment: .center)
        }.padding(20)
    }
}

struct CountryChoiceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CountryChoiceSearchView(viewModel: CountryChoiceViewModel())
            .previewLayout(.sizeThatFits)
    }
}

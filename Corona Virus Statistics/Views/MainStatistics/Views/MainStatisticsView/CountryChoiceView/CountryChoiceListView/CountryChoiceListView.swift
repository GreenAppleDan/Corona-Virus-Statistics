//
//  CountryChoiceListView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryChoiceListView: View {
    var text: String
    var body: some View {
        Text(text)
        .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 0))
        .frame(width: UIScreen.main.bounds.width , alignment: .leading)
    }
}

struct CountryChoiceListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryChoiceListView(text: "Hello World")
            .previewLayout(.sizeThatFits)
    }
}

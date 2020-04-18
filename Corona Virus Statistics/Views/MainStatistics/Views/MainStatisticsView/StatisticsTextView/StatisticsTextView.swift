//
//  StatisticsTextView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct StatisticsTextView: View {
    var body: some View {
        VStack {
        Text(text)
            .padding(20)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .minimumScaleFactor(0.7)
            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
            .modifier(BrandGradient())
        }
            
    }
    
    private var bounds: CGRect { UIScreen.main.bounds }
    public var text: String
}

struct StatisticsTextView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsTextView(text: "Hello, World!")
            .previewLayout(.sizeThatFits)
    }
}

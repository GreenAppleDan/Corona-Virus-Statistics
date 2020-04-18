//
//  BrandGradient.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct BrandGradient: ViewModifier {
    var colors: [Color] = [Color(red: 200/255, green: 43/255, blue: 254/255), Color(red: 54/255, green: 115/255, blue: 254/255)]
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
    }
}

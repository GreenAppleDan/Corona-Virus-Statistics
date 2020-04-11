//
//  CustomShadow.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CustomShadow: ViewModifier {
    var shadowRadius: CGFloat
    func body(content: Content) -> some View {
        content
            .clipped()
            .shadow(radius: shadowRadius)
    }
}

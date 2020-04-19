//
//  OffsetModifier.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 19.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    var x: CGFloat
    var y: CGFloat
    func body(content: Content) -> some View {
        content
            .offset(x: x, y: y)
    }
}

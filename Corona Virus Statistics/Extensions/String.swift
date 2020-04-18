//
//  String.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

extension String {
    func formantForURL() -> String {
        self.trimmingCharacters(in: .whitespaces)
        .replacingOccurrences(of: " ", with: "-")
    }
}

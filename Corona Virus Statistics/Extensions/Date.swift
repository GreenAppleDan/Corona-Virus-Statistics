//
//  Date.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 19.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation


extension Date {
    func getFormattedBasicString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        return formatter.string(from: self)
    }
}

//
//  Country.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public struct Country: Codable {
    public let Country: String
    public let Slug: String
    
    
    public var name: String {
        self.Country
    }
    public var slug: String {
        self.Slug
    }
    
    public init(countryName: String, countrySlug: String) {
        self.Country = countryName
        self.Slug = countrySlug
    }
}

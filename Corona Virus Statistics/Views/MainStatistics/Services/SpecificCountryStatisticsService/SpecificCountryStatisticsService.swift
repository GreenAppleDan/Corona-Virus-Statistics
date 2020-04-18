//
//  SpecificCountryStatisticsService.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public struct SpecificCountryStatisticsService {
    private func createUrlFromCountryName(_ name: String) -> URL {
        URL(string: ("https://api.covid19api.com/live/country/\(formatCountryName(name))/status/confirmed").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    private func formatCountryName(_ name: String) -> String {
        return name
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: "-")
    }
    
    public init() { }
}

extension SpecificCountryStatisticsService: SpecificCountryStatisticsServiceDataPublisher {
    public func publisher(countryName: String) -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: createUrlFromCountryName(countryName))
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    
}

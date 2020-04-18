//
//  SpecificCountryDailyStatisticsService.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public struct SpecificCountryDailyStatisticsService {
    private func createUrlFromCountryName(_ name: String) -> URL {
        URL(string: ("https://api.covid19api.com/country/\(name.formantForURL())/status/confirmed/live").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    public init() {}
}

extension SpecificCountryDailyStatisticsService : SpecificCountryDailyStatisticsServiceDataPublisher {
    public func publisher(countryName: String) -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: createUrlFromCountryName(countryName))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

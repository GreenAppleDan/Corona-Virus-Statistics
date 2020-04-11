//
//  VirusStatisticsService.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public struct VirusStatisticsService {
    private var url: URL? {
        guard let url = URL(string: "https://api.covid19api.com/summary") else { return nil }
        return url
    }
    
    public init() { }
}

extension VirusStatisticsService: VirusStatisticsServiceDataPublisher {
    public func publisherForOverallCases() -> AnyPublisher<Data, URLError> {
        URLSession.shared
        .dataTaskPublisher(for: url!)
        .map(\.data)
        .eraseToAnyPublisher()
    }
    
    public func publisherForCountry(countryName: String) -> AnyPublisher<Data, URLError> {
        let processedCountryName = countryName.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "-")
        
        return URLSession.shared
        .dataTaskPublisher(for: URL(string: "https://api.covid19api.com/live/country/\(processedCountryName)/status/confirmed")!)
        .map(\.data)
        .eraseToAnyPublisher()
    }
    
    
}

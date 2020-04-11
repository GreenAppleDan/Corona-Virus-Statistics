//
//  AllCountriesService.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public struct AllCountriesService {
    private var url: URL? {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else { return nil }
        return url
    }
    
    public init() { }
}

extension AllCountriesService: AllCountriesServiceDataPublisher {
    public func publisher() -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url!)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    
}

//
//  CountryChoiceViewModel.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Combine
import Foundation

public final class CountryChoiceViewModel: ObservableObject {
    @Published public var searchText: String = ""
    @Published public var chosenCountry: Country = Country(countryName: "mock", countrySlug: "mock")
    @Published public var virusCountryStatistics: VirusCountryStatistics = VirusCountryStatistics()
    
    private let specificCountryStatisticsService: SpecificCountryStatisticsService
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    public init (specificCountryStatisticsService: SpecificCountryStatisticsService = SpecificCountryStatisticsService()) {
        self.specificCountryStatisticsService = specificCountryStatisticsService
    }
    public func fetchLatestStatisticsFor(countryName: String, closure: @escaping () -> Void) {
        specificCountryStatisticsService.publisher(countryName: countryName)
            .retry(3)
            .receive(on: DispatchQueue.main)
            .replaceError(with: Data())
            .tryMap { data -> VirusCountryStatistics in
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]], let rawStatistics = json.last {
                    guard let statistics = VirusCountryStatistics.deserialize(from: rawStatistics) else { throw URLError(.cannotDecodeRawData)}
                    return statistics
                } else {
                    throw URLError(.cannotDecodeRawData)
                }
        }.replaceError(with: VirusCountryStatistics())
            .handleEvents(receiveCompletion: {_ in closure()})
            .assign(to: \.virusCountryStatistics, on: self)
            .store(in: &subscriptions)
        
    }
}

//
//  MainStatisticsViewModel.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public final class MainStatisticsViewModel: ObservableObject {
    
    private static let decoder = JSONDecoder()
    
    @Published public var countries: [Country] = []
    @Published public var overallStatistics: VirusWorldwideStatistics = VirusWorldwideStatistics()
    
    
    
    private let allCountriesService: AllCountriesService
    private let virusStatisticsService: VirusStatisticsService

    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(allCountriesService: AllCountriesService = AllCountriesService(), virusStatisticsService: VirusStatisticsService = VirusStatisticsService()) {
        self.allCountriesService = allCountriesService
        self.virusStatisticsService = virusStatisticsService
        fetchAllCountries()
    }
    
    
    private func fetchAllCountries() {
        
        allCountriesService.publisher()
            .retry(3)
            .decode(type: [Country].self, decoder: Self.decoder)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .map {$0.filter { $0.name != "China" && $0.name != "Canada"}}
            .assign(to: \.countries, on: self)
            .store(in: &subscriptions)
    }
    
    public func fetchOverallVirusCases() {
        virusStatisticsService.publisherForOverallCases()
            .retry(3)
            .receive(on: DispatchQueue.main)
            .replaceError(with: Data())
            .tryMap { data -> VirusWorldwideStatistics in
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let rawStatistics = json["Global"] as? [String: Any] {
                    guard let statistics = VirusWorldwideStatistics.deserialize(from: rawStatistics) else { throw URLError(.cannotDecodeRawData)}
                    return statistics
                } else {
                    throw URLError(.cannotDecodeRawData)
                }
        }.replaceError(with: VirusWorldwideStatistics())
            .assign(to: \.overallStatistics, on: self)
            .store(in: &subscriptions)
    }
    
    
    
    
}

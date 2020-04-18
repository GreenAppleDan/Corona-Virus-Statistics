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
    @Published public var virusCountryStatistics: VirusCountryStatistics = VirusCountryStatistics()
    
    @Published public var searchText: String = ""
    @Published public var chosenCountryName = ""
    
    private let allCountriesService: AllCountriesService
    private let virusStatisticsService: VirusStatisticsService
    private let specificCountryStatisticsService: SpecificCountryStatisticsService
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(allCountriesService: AllCountriesService = AllCountriesService(), virusStatisticsService: VirusStatisticsService = VirusStatisticsService(), specificCountryStatisticsService: SpecificCountryStatisticsService = SpecificCountryStatisticsService()) {
        self.allCountriesService = allCountriesService
        self.virusStatisticsService = virusStatisticsService
        self.specificCountryStatisticsService = specificCountryStatisticsService
        fetchAllCountries()
    }
    
    
    private func fetchAllCountries() {
        
        allCountriesService.publisher()
            .retry(3)
            .decode(type: [Country].self, decoder: Self.decoder)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
//            .map {$0.filter { $0.name.range(of: "\\P{English}", options: .regularExpression) == nil && $0.name != "China"}}
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
    
    public func fetchLatestStatisticsFor(countryName: String) {
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
            .assign(to: \.virusCountryStatistics, on: self)
            .store(in: &subscriptions)
        
    }
    
    
}

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
    @Published public var virusCountryStatisticsLatest: VirusCountryStatisticsLatest = VirusCountryStatisticsLatest()
    @Published public var virusDailyCountryStatistics : [VirusCountryStatisticsConfirmedCasesSpecificDay] = [VirusCountryStatisticsConfirmedCasesSpecificDay]()
    
    private let specificCountryStatisticsService: SpecificCountryStatisticsService
    private let specificCountryDailyStatisticsService: SpecificCountryDailyStatisticsService
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    public init (specificCountryStatisticsService: SpecificCountryStatisticsService = SpecificCountryStatisticsService(), specificCountryDailyStatisticsService: SpecificCountryDailyStatisticsService = SpecificCountryDailyStatisticsService()) {
        self.specificCountryStatisticsService = specificCountryStatisticsService
        self.specificCountryDailyStatisticsService = specificCountryDailyStatisticsService
    }
    public func fetchLatestStatisticsFor(countryName: String, closure: @escaping () -> Void) {
        specificCountryStatisticsService.publisher(countryName: countryName)
            .retry(3)
            .receive(on: DispatchQueue.main)
            .replaceError(with: Data())
            .tryMap { data -> VirusCountryStatisticsLatest in
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]], let rawStatistics = json.last {
                    guard let statistics = VirusCountryStatisticsLatest.deserialize(from: rawStatistics) else { throw URLError(.cannotDecodeRawData)}
                    return statistics
                } else {
                    throw URLError(.cannotDecodeRawData)
                }
        }.replaceError(with: VirusCountryStatisticsLatest())
            .handleEvents(receiveCompletion: {_ in closure()})
            .assign(to: \.virusCountryStatisticsLatest, on: self)
            .store(in: &subscriptions)
        
    }
    
    public func fetchAllDailyStatisticsFor(countryName: String) {
        specificCountryDailyStatisticsService.publisher(countryName: countryName)
            .retry(3)
            .receive(on: DispatchQueue.main)
            .replaceError(with: Data())
            .tryMap { data -> [VirusCountryStatisticsConfirmedCasesSpecificDay] in
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var statisticsArray = [VirusCountryStatisticsConfirmedCasesSpecificDay]()
                    for rawStatistics in json {
                        guard let statistics = VirusCountryStatisticsConfirmedCasesSpecificDay.deserialize(from: rawStatistics) else {
                            throw URLError(.cannotDecodeRawData)
                        }
                        statisticsArray.append(statistics)
                    }
                    return statisticsArray
                } else {
                    throw URLError(.cannotDecodeRawData)
                }
        }.replaceError(with: [VirusCountryStatisticsConfirmedCasesSpecificDay()])
            .assign(to: \.virusDailyCountryStatistics, on: self)
            .store(in: &subscriptions)
    }
}

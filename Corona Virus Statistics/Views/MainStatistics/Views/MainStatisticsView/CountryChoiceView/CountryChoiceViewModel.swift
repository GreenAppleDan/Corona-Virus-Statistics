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
    
    public func getIndicesOfThreeMiddleDaysForCountryStatistics() -> [Int] {
        guard virusDailyCountryStatistics.count > 30 else { return []}
        var indices = [Int]()
        guard let maxCasesValue = virusDailyCountryStatistics.max()?.Cases else { return []}
        guard maxCasesValue > 100 else { return []}
        var objectsToFindClosestOnes = [maxCasesValue/20 * 1, maxCasesValue/20 * 4, maxCasesValue/20 * 10]
        
        
        for index in 0...2  {
            let closest = virusDailyCountryStatistics.enumerated().min(by: { abs($0.1.Cases! - objectsToFindClosestOnes[index]) < abs($1.1.Cases! - objectsToFindClosestOnes[index])})
            indices.append(closest!.offset)
        }
        
        return indices
        
    }
}

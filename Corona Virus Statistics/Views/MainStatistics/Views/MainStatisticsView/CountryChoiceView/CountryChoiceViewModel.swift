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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]], !json.isEmpty {
                    guard let statistics = [VirusCountryStatisticsLatest].deserialize(from: json) else { throw URLError(.cannotDecodeRawData)}
                    let unwrappedArray =  statistics.compactMap({$0}).reversed()
                    let lastDateValuesWithUniqueProvince = Set(unwrappedArray)
                    let accumulatedCases = lastDateValuesWithUniqueProvince.reduce(VirusCountryStatisticsLatest(Active: 0, Recovered: 0, Confirmed: 0, Deaths: 0)) { initial, object in
                        initial.Confirmed! += object.Confirmed ?? 0
                        initial.Deaths! += object.Deaths ?? 0
                        initial.Active! += object.Active ?? 0
                        initial.Recovered! += object.Recovered ?? 0
                        return initial
                    }
                    
                    return accumulatedCases
                    
                } else {
                    throw URLError(.cannotDecodeRawData)
                }
        }.replaceError(with: VirusCountryStatisticsLatest())
            .handleEvents(receiveCompletion: {_ in closure()})
            .assign(to: \.virusCountryStatisticsLatest, on: self)
            .store(in: &subscriptions)
        
    }
    
    public func fetchAllDailyStatisticsFor(countryName: String, completion: @escaping () -> Void) {
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
            .handleEvents(receiveCompletion: {_ in completion()})
            .assign(to: \.virusDailyCountryStatistics, on: self)
            .store(in: &subscriptions)
    }
    
    public func getIndicesOfThreeMiddleDaysForCountryStatistics() -> [Int] {
        guard virusDailyCountryStatistics.count > 30 else { return []}
        var indices = [Int]()
        guard let maxCasesValue = virusDailyCountryStatistics.max()?.Cases else { return []}
        guard maxCasesValue > 100 else { return []}
        let objectsToFindClosestOnes = [maxCasesValue/20 * 1, maxCasesValue/20 * 4, maxCasesValue/20 * 10]
        
        
        for index in 0...2  {
            let closest = virusDailyCountryStatistics.enumerated().min(by: { abs($0.1.Cases! - objectsToFindClosestOnes[index]) < abs($1.1.Cases! - objectsToFindClosestOnes[index])})
            indices.append(closest!.offset)
        }
        
        return indices
        
    }
    
    public func getMaxCasesDaysForCountryStatistics() -> Int {
        guard let maxCasesValue = virusDailyCountryStatistics.max()?.Cases else { return 0}
        return maxCasesValue
    }
}

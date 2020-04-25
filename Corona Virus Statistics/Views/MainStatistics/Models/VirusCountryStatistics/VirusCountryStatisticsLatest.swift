//
//  VirusCountryStatisticsLatest.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

public class VirusCountryStatisticsLatest: HandyJSON {
    public var Confirmed: Int?
    public var Deaths: Int?
    public var Recovered: Int?
    public var Active: Int?
    public var Province: String?
    public var date: Date?
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<<
            date <-- ("Date", TransformOf<Date, String>(fromJSON: { (response) -> Date? in
                guard let result = response else { return nil }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let dateFinal = dateFormatter.date(from: result)
                return dateFinal
                
            }, toJSON: { _ in return nil }))
    }
    
    public required init() {}
    
    public init(Active: Int, Recovered: Int, Confirmed: Int, Deaths: Int) {
        self.Active = Active
        self.Confirmed = Confirmed
        self.Recovered = Recovered
        self.Deaths = Deaths
    }
}


extension VirusCountryStatisticsLatest: Hashable {
    public static func == (lhs: VirusCountryStatisticsLatest, rhs: VirusCountryStatisticsLatest) -> Bool {
        return lhs.Province == rhs.Province
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Province)
    }
}

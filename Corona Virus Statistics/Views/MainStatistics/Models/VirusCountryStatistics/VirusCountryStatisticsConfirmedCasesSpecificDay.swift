//
//  VirusCountryStatisticsSpecificDay.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

public class VirusCountryStatisticsConfirmedCasesSpecificDay: HandyJSON {
    public var Country: String?
    public var Cases: Int?
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
                print(dateFinal)
                return dateFinal
                
            }, toJSON: { _ in return nil }))
    }
    
    required public init() {}
}

extension VirusCountryStatisticsConfirmedCasesSpecificDay: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Country)
        hasher.combine(Cases)
        hasher.combine(date)
    }
    
    public static func == (lhs: VirusCountryStatisticsConfirmedCasesSpecificDay, rhs: VirusCountryStatisticsConfirmedCasesSpecificDay) -> Bool {
        return lhs.date == rhs.date && lhs.Cases == rhs.Cases
    }
    
    
}

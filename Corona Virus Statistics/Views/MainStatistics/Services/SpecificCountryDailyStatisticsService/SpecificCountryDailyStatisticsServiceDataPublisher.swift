//
//  SpecificCountryDailyStatisticsServiceDataPublisher.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public protocol SpecificCountryDailyStatisticsServiceDataPublisher {
    func publisher(countryName: String) -> AnyPublisher<Data, URLError>
}

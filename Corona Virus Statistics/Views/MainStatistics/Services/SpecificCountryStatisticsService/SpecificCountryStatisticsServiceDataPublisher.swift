//
//  SpecificCountryStatisticsServiceDataPublisher.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 11.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public protocol SpecificCountryStatisticsServiceDataPublisher {
    func publisher(countryName: String) -> AnyPublisher<Data, URLError>
}

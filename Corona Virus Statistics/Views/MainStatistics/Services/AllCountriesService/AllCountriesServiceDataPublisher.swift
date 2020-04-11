//
//  AllCountriesServiceDataPublisher.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import Combine

public protocol AllCountriesServiceDataPublisher {
    func publisher() -> AnyPublisher<Data, URLError>
}

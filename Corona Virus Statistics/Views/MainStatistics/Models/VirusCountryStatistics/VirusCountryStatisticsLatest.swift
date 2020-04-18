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
    
    public required init() {}
}

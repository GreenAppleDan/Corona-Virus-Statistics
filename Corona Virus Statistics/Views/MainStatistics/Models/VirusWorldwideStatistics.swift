//
//  VirusWorldwideStatistics.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 10.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation
import HandyJSON

public class VirusWorldwideStatistics: HandyJSON {
    public var NewConfirmed: Int?
    public var TotalConfirmed: Int?
    public var NewDeaths: Int?
    public var TotalDeaths: Int?
    public var NewRecovered: Int?
    public var TotalRecovered: Int?
    
    public required init() {}
}

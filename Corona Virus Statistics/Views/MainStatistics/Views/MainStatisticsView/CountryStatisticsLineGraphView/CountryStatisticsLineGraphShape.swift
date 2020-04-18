//
//  CountryStatisticsLineGraphShape.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryStatisticsLineGraphShape: Shape {
    @ObservedObject var viewModel: CountryChoiceViewModel
    
    func path(in rect: CGRect) -> Path {
        func getYPointFromStatistics(_ statistics: VirusCountryStatisticsConfirmedCasesSpecificDay) -> CGFloat {
            return rect.height - rect.height * CGFloat(Double(statistics.Cases ?? 1) / Double(sortedStatistics().last?.Cases ?? 1))
        }
        
        func point(at index: Int) -> CGPoint {
            let point = sortedStatistics()[index]
            let x = rect.width * CGFloat(index) / CGFloat(sortedStatistics().count - 1)
            let y = getYPointFromStatistics(point)
            return CGPoint(x: x, y: y)
        }
        
        return Path { p in
            guard sortedStatistics().count > 1 else { return }
            //let start = sortedStatistics()[0]
            p.move(to: CGPoint(x: 0, y: rect.height))
            
            for idx in sortedStatistics().indices {
                print(point(at: idx))
                p.addLine(to: point(at: idx))
            }
        }
    }
    
    func sortedStatistics() -> [VirusCountryStatisticsConfirmedCasesSpecificDay] {
        return viewModel.virusDailyCountryStatistics.filter{$0.Cases != 0}.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
    }
    
    
    func caseOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, height: CGFloat) -> CGFloat {
        CGFloat(Double(object.Cases! / (viewModel.virusDailyCountryStatistics.compactMap{$0.Cases}.max()!)) * Double(height))
    }
    
    func dayOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, dayWidth: CGFloat) -> CGFloat {
        CGFloat(viewModel.virusDailyCountryStatistics.firstIndex(of: object)!) * dayWidth
    }
    
    
}


//
//  CountryStatisticsLineGraphView.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryStatisticsLineGraphView: View {
    @EnvironmentObject var viewModel: CountryChoiceViewModel
    
    var body: some View {
        GeometryReader { reader in
            ForEach(self.viewModel.virusDailyCountryStatistics, id: \.self) { statistics in
                Path { p in
                    let daySectionWidth = self.daySectionWidth(reader.size.width, count: self.viewModel.virusDailyCountryStatistics.count)
                    let caseSectionHeight = self.caseSectionHeight(reader.size.height, count: self.viewModel.virusDailyCountryStatistics.count)
                    
                    let dayOffset = self.dayOffset(statistics, dayWidth: daySectionWidth)
                    let caseOffset = self.caseOffset(statistics, caseHeight: caseSectionHeight)
                    
                    p.addLine(to: CGPoint(x: dayOffset, y: reader.size.height - caseOffset))
                    p.move(to: CGPoint(x: dayOffset, y: reader.size.height - caseOffset))
                    
                }.stroke()
            }
        }
    }
    
    func caseSectionHeight(_ height: CGFloat, count: Int) -> CGFloat {
        return height / CGFloat(count)
    }
    
    func daySectionWidth(_ height: CGFloat, count: Int) -> CGFloat {
        return height / CGFloat(count)
    }
    
    func caseOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, caseHeight: CGFloat) -> CGFloat {
        CGFloat(viewModel.virusDailyCountryStatistics.firstIndex(of: object)!) * caseHeight
    }
    
    func dayOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, dayWidth: CGFloat) -> CGFloat {
        CGFloat(viewModel.virusDailyCountryStatistics.firstIndex(of: object)!) * dayWidth
    }
    
    
}

struct CountryStatisticsLineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatisticsLineGraphView()
    }
}

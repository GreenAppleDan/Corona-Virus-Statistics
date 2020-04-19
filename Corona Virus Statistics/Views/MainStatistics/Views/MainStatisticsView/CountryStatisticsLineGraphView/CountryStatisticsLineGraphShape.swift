//
//  CountryStatisticsLineGraphShape.swift
//  Corona Virus Statistics
//
//  Created by Денис Жукоборский on 18.04.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import SwiftUI

struct CountryStatisticsLineGraphShape: View {
    @EnvironmentObject var viewModel: CountryChoiceViewModel
    var body: some View {
        GeometryReader { reader in
            ZStack {
                
                ForEach(self.sortedStatistics().indices) { idx in
                    Group {
                        if (self.viewModel.getIndicesOfThreeMiddleDaysForCountryStatistics()).contains(idx)  {
                            
                            Text(self.sortedStatistics()[idx].date!.getFormattedBasicString() ?? "")
                                .foregroundColor(ColorStorage.brightOrange)
                                .rotationEffect(.degrees(-90))
                                .font(.system(size: 8, design: .default))
                                .offset(x: self.point(at: idx, rect: reader).x - reader.size.width/2 - 5, y: reader.size.height/2 - self.getHeightFromBottomForDatesText(index: idx, rect: reader))
                            
                            Path { p in
                                p.move(to: CGPoint(x: self.point(at: idx, rect: reader).x, y: reader.size.height))
                                p.addLine(to: CGPoint(x: self.point(at: idx, rect: reader).x, y: 0))
                                p.move(to: CGPoint(x: reader.size.width, y: self.point(at: idx, rect: reader).y))
                                p.addLine(to: CGPoint(x: 0, y: self.point(at: idx, rect: reader).y))
                                
                            }.stroke(lineWidth: 0.7)
                            
                            //sortedStatistics()[idx].date
                            Text(String(self.sortedStatistics()[idx].Cases!))
                                .offset(x: 40 - reader.size.width/2, y: self.point(at: idx, rect: reader).y - reader.size.height/2 - 15)
                            
                            
                        }
                    }
                }
                //                ForEach(self.sortedStatistics().indices) { idx in
                //                    if idx % 7 == 0 && idx != 0 {
                //                        Group {
                //                            Path { p in
                //                                p.move(to: CGPoint(x: self.point(at: idx, rect: reader).x, y: reader.size.height))
                //                                p.addLine(to: CGPoint(x: self.point(at: idx, rect: reader).x, y: 0))
                //                                //                            p.move(to: CGPoint(x: reader.size.width, y: self.point(at: idx, rect: reader).y))
                //                                //                            p.addLine(to: CGPoint(x: 0, y: self.point(at: idx, rect: reader).y))
                //
                //                            }.stroke(lineWidth: 1)
                //
                //                            //sortedStatistics()[idx].date
                //                            //Text("abc")
                //                            // .offset(x: 5, y: self.point(at: idx, rect: reader).y)
                //                        }
                //                    }
                //                }
                
                Path { p in
                    guard self.sortedStatistics().count > 1 else { return }
                    //let start = sortedStatistics()[0]
                    p.move(to: CGPoint(x: 0, y: reader.size.height))
                    
                    for idx in self.sortedStatistics().indices {
                        print(self.point(at: idx, rect: reader))
                        p.addLine(to: self.point(at: idx, rect: reader))
                    }
                    
                }.stroke(LinearGradient(gradient: Gradient(colors: ColorStorage.brandGradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 4)
                
            }
        }
    }
    
    func getYPointFromStatistics(_ statistics: VirusCountryStatisticsConfirmedCasesSpecificDay, rect: GeometryProxy) -> CGFloat {
        return rect.size.height - rect.size.height * CGFloat(Double(statistics.Cases ?? 1) / Double(sortedStatistics().last?.Cases ?? 1))
    }
    
    func point(at index: Int, rect: GeometryProxy) -> CGPoint {
        let point = sortedStatistics()[index]
        let x = rect.size.width * CGFloat(index) / CGFloat(sortedStatistics().count - 1)
        let y = getYPointFromStatistics(point, rect: rect)
        return CGPoint(x: x, y: y)
    }
    
    func getHeightFromBottomForDatesText(index: Int, rect: GeometryProxy) -> CGFloat {
        guard let position = viewModel.getIndicesOfThreeMiddleDaysForCountryStatistics().firstIndex(of: index) else { return 0}
        
        switch position {
        case 0, 1, 2:
            return (rect.size.height / 5) * (CGFloat(position) + 1)
        default:
            return 0
        }
    }
    
    
    
    func sortedStatistics() -> [VirusCountryStatisticsConfirmedCasesSpecificDay] {
        return viewModel.virusDailyCountryStatistics.sorted(by: {$0.date ?? Date() < $1.date ?? Date()})
    }
    
    
    //    func caseOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, height: CGFloat) -> CGFloat {
    //        CGFloat(Double(object.Cases! / (viewModel.virusDailyCountryStatistics.compactMap{$0.Cases}.max()!)) * Double(height))
    //    }
    //
    //    func dayOffset(_ object: VirusCountryStatisticsConfirmedCasesSpecificDay, dayWidth: CGFloat) -> CGFloat {
    //        CGFloat(viewModel.virusDailyCountryStatistics.firstIndex(of: object)!) * dayWidth
    //    }
    
    
}


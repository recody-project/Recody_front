//
//  InsiteStatisticsGraphChartView.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/02.
//

import Foundation
import UIKit
import Charts
import SnapKit
class InsiteStatisticsGraphChartView : UIView,ChartViewDelegate{
    var chartView = PieChartView()
    convenience init() {
        self.init(frame: CGRect())
        self.backgroundColor = .clear
        self.addSubview(chartView)
        chartView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        chartView.delegate = self
        chartView.legend.enabled = false
        chartView.holeColor = .clear
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        chartView.drawEntryLabelsEnabled = false
        self.chartView.holeRadiusPercent = 0.7
    }
 
    func setDataCount(total:Int,best:Int) {
        let percent = (best * 100) / total
        let percentDouble = Double(percent)
        let remaindPercent = 100.0 - percentDouble
        let pInt = Int(percent) ?? 0
        
        var itemColors = [UIColor]()
        let list :[Double] = (0...1).map { idx -> Double in
            if idx == 1 {
                itemColors.append(UIColor(hexString: "#9FA5D6"))
                return remaindPercent
            }else{
                itemColors.append(UIColor(hexString: "#666FC1"))
                return percentDouble
            }
        }
        let count = list.count
        var total = 0.0
        list.forEach({ it in
            total += it
        })
        
        var index = 0
        let entries = list.map { (idx) -> PieChartDataEntry in
            let entry = PieChartDataEntry(value: (100 * idx / total))
            index += 1
            return entry
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.drawIconsEnabled = false
        set.sliceSpace = 0.0
        set.colors = itemColors
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFont(.boldSystemFont(ofSize: 17))
        data.setValueTextColor(.clear)
        chartView.data = data
        chartView.highlightValues(nil)
    }
    
}

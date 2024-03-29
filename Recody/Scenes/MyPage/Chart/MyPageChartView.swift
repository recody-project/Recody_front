//
//  MyPageChartView.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/25.
//

import Foundation
import UIKit
import Charts
import SnapKit
class MyPageChartView : UIView, ChartViewDelegate {
    var chartView = PieChartView()
    private var labelPercent = UILabel()
    private var totalColor = UIColor(hexString: "#9FA5D6")
    private var bestColor = UIColor(hexString: "#666FC1")
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
        chartView.entryLabelFont = UIFont.fontWithName(type: FontType.regular, size: 12)
        chartView.drawEntryLabelsEnabled = false
        self.chartView.holeRadiusPercent = 0.7
        labelPercent = UILabel()
        labelPercent.font = UIFont.fontWithName(type: FontType.regular, size: 12)
        labelPercent.textColor = UIColor(hexString: "#222222")
        self.addSubview(labelPercent)
        self.bringSubviewToFront(labelPercent)
        labelPercent.snp.makeConstraints({
            $0.centerX.centerY.equalToSuperview()
        })
    }
    func setColor(totalColor: UIColor, bestColor: UIColor) {
        self.totalColor = totalColor
        self.bestColor = bestColor
    }
    func setDataCount(total: Int, best: Int) {
        labelPercent.text = "\(best)%"
        let percent = (best * 100) / total
        let percentDouble = Double(percent)
        let remaindPercent = 100.0 - percentDouble
        // pInt
        _ = Int(percent)
        var itemColors = [UIColor]()
        let list: [Double] = (0...1).map { idx -> Double in
            if idx == 1 {
                itemColors.append(self.totalColor)
                return remaindPercent
            } else {
                itemColors.append(self.bestColor)
                return percentDouble
            }
        }
        // count_
        _ = list.count
        var total = 0.0
        list.forEach({ its in
            total += its
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
        data.setValueFont(UIFont.fontWithName(type: FontType.regular, size: 14))
        data.setValueTextColor(.clear)
        chartView.data = data
        chartView.highlightValues(nil)
    }
}

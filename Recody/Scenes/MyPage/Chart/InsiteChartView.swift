//
//  InsiteChartView.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/04.
//

import Foundation
import Charts
import UIKit
import SnapKit
/***
    막대그래프 6개 라인1개로 으로 구성된 그래프
     viewdidload () 함수내에서 아래 코드 실행
     
     let chart = SpiderChart()
      self.view.addSubview(chart)
      chart.snp.makeConstraints({ make in
          make.top.left.right.equalToSuperview()
          make.height.equalTo(self.view.frame.height/2)
      })
 */

class CombinChart : UIView,ChartViewDelegate{
    
    let chartView = CombinedChartView()
    let topView = UIView()
    var stackView = UIStackView()
    var barItems = [(point :CGPoint,color :UIColor,type : String)]()
    let barColors : [UIColor] = [.red.withAlphaComponent(0.5),
                                 .gray.withAlphaComponent(0.5),
                                 .blue.withAlphaComponent(0.5),
                                 .green.withAlphaComponent(0.5),
                                 .yellow.withAlphaComponent(0.5),
                                 .purple.withAlphaComponent(0.5)]
    let barColor : UIColor = UIColor.init(hexString: "#000000")
    
    convenience init() {
        self.init(frame: CGRect())
        
        self.addSubview(chartView)
        chartView.snp.makeConstraints({ make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-10)
        })
     
        chartView.delegate = self
        chartView.isUserInteractionEnabled = false
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.leftAxis.enabled = false
        chartView.maxVisibleCount = 60
        chartView.legend.enabled  = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.fontWithName(type: FontType.regular, size: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 10
//        let formatter = BarNumberFormatter()
//        xAxis.valueFormatter = formatter
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = ""
        leftAxisFormatter.positiveSuffix = ""
        
//        let leftAxis = chartView.leftAxis
//        leftAxis.labelFont = .systemFont(ofSize: 10)
//        leftAxis.labelCount = 8
//        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
//        leftAxis.labelPosition = .outsideChart
//        leftAxis.spaceTop = 0.15
//        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
//
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = UIFont.fontWithName(type: FontType.regular, size: 10)
        rightAxis.labelCount = 8
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        rightAxis.spaceTop = 0.3
        rightAxis.axisMinimum = 0
        initTopView()
        setupStackView()
        setData()
    }
    
    func initTopView() {
        self.addSubview(topView)
        topView.snp.makeConstraints({ make in
            make.top.right.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        })
        
        // strCount
        _ = 0
    }
    func setupStackView() {
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        
        self.addSubview(stackView)
        self.bringSubviewToFront(stackView)
        stackView.snp.makeConstraints({
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(10)
            $0.height.equalTo(20)
        })
        
        for index in (1...10) {
            let label = UILabel()
            label.font = UIFont.fontWithName(type: FontType.regular, size: 14)
            label.textColor = UIColor.init(hexString: "#666666")
            label.text = "\(Double(index) * 0.5)"
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
    
    func updateChartData() {
        self.chartView.data = nil
        
        self.setChartData()
    }

    func setData() {
        barItems.append((CGPoint(x: 0.0, y: 3.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 1.5), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 0.5), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 3.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 3.5), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 5.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 4.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 3.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 4.0), barColor, ""))
        barItems.append((CGPoint(x: 0.0, y: 2.0), barColor, ""))
        updateChartData()
    }
    func setChartData() {
        let data = CombinedChartData()
//        data.lineData = generateLineData()
        data.barData = generateBarData()
//        self.chartView.xAxis.axisMaximum = data.xMax + 0.5
//        self.chartView.xAxis.axisMinimum = data.xMin + 0.5
        self.chartView.xAxis.axisMinimum = 0.5
        self.chartView.xAxis.axisMaximum = 5.0
        self.chartView.data = data
    }
    
    func generateBarChartDataSet(
        _ barName: String,
        _ color: UIColor,
        _ point: CGPoint) -> BarChartDataSet {
        
        let entries = [BarChartDataEntry(x: point.x, y: point.y )]
        let set1 = BarChartDataSet(entries: entries, label: barName )
        set1.setColor(color)
//        set1.valueTextColor = .black
//        set1.valueFont = .systemFont(ofSize: 15)
        set1.axisDependency = .left
        set1.valueTextColor = UIColor.init(hexString: "#666666")
        set1.valueFont = UIFont.fontWithName(type: .regular, size: 14)
        set1.drawValuesEnabled = true
        return set1
    }
    func generateBarData() -> BarChartData {
        
        let groupSpace = 0.0
        let barSpace = 0.2 // x2 dataset
        let barWidth = 0.25 // x2 dataset
        
        var index: CGFloat = 0.0
        let dataSet = barItems.map({ its -> BarChartDataSet in
            let item = generateBarChartDataSet("1", its.color, CGPoint(x: index, y: its.point.y))
            index += 1
            return item
        })
        let data: BarChartData = BarChartData(dataSets: dataSet )
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        let rightAxis = chartView.rightAxis
        leftAxis.drawAxisLineEnabled = false
        rightAxis.drawAxisLineEnabled = true
        rightAxis.enabled = false
        let xAxis = chartView.xAxis
        xAxis.drawLabelsEnabled = false
        xAxis.labelTextColor = UIColor.init(hexString: "#666666")
        xAxis.labelFont = UIFont.fontWithName(type: FontType.regular, size: 14)
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 10
        xAxis.gridColor = .white
        xAxis.axisLineColor = UIColor.init(hexString: "#666FC1")
        xAxis.drawGridLinesEnabled = true
        xAxis.enabled = true
        let numberFormatter = BarNumberFormatter()
        data.setValueFormatter(numberFormatter)
        data.barWidth = barWidth
        
        // make this BarData object grouped
        data.groupBars(fromX: 0.5, groupSpace: groupSpace, barSpace: barSpace)
        return data
    }
    
}

class BarNumberFormatter: ValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueInt = Int(value)
        return "\(valueInt)"
    }
}

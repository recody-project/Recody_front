//
//  InsightStatisticsGraphCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/31.
//

import UIKit
//2
class InsightStatisticsGraphCell: UITableViewCell,ObservingTableCell {
    var eventDelegate: ObservingTableCellEvent?
//    @IBOutlet weak var lbNickName:UILabel! //닉네임
//    @IBOutlet weak var analysisTypeName:UILabel! //분석유형이름
    @IBOutlet weak var lbTop1:UILabel!
    @IBOutlet weak var lbTop2:UILabel!
    @IBOutlet weak var chartView: UIView!
    var borderViews = [UIView]()
    @IBOutlet weak var cellView: UIView?
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            chageData()
        }
    }
    func chageData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
        lbTop1.text = "영화"
        lbTop2.text = "드라마"
        settingBorderViews()
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.statisticsGraphCellEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let chart1 = InsiteStatisticsGraphChartView()
        chart1.setDataCount(total:33,best: 26)
        self.chartView.addSubview(chart1)
        chart1.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        setupLabels()
        chageData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func setupLabels(){
        [lbTop1,lbTop2].forEach({ label in
            label?.textColor = UIColor.init(hexString: "#666FC1")
            label?.font = .systemFont(ofSize: 12)
        })
    }
    private func settingBorderViews(){
        self.borderViews.forEach({
            $0.removeFromSuperview()
        })
        self.borderViews.removeAll()
        [lbTop1,lbTop2].forEach({ label in
            let view = UIView()
            self.cellView?.addSubview(view)
            self.cellView?.bringSubviewToFront(view)
            view.backgroundColor = .white
            view.layer.cornerRadius = label!.frame.height/2
            view.borderColor = UIColor.init(hexString: "#666FC1")
            view.borderWidth = 1.0
            view.snp.makeConstraints({
                $0.centerX.equalTo(label!.snp.centerX)
                $0.centerY.equalTo(label!.snp.centerY)
                $0.height.equalTo(label!.snp.height).offset(8)
                $0.width.equalTo(label!.snp.width).offset(16)
            })
            self.cellView?.bringSubviewToFront(label!)
        })
    }
}

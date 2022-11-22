//
//  InsightStatisticsCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/31.
//

import UIKit
//1
class InsightStatisticsCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbNickName:UILabel!
    @IBOutlet weak var lbMonth:UILabel! //월
    @IBOutlet weak var lbWorkCount:UILabel! //감상작품
    @IBOutlet weak var lbRecordCount:UILabel! //기록수
    @IBOutlet weak var cellView: UIView?
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    var eventDelegate: ObservingTableCellEvent?
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
        lbNickName.text=data.stringValue(key: "nickName")
        lbMonth.text=data.stringValue(key: "month")
        lbWorkCount.text=data.stringValue(key: "workCount")
        lbRecordCount.text=data.stringValue(key: "recordCount")
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.statisticsEvent.rawValue,index:viewmodel!.index)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


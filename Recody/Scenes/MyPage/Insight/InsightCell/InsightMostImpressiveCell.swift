//
//  InsightMostImpressiveCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/31.
//

import UIKit
//3
//가장 길게적은
class InsightMostImpressiveCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbTitle:UILabel!
    @IBOutlet weak var lbGenre:UILabel!
    @IBOutlet weak var lbWorkTitle:UILabel!
    @IBOutlet weak var lbRecordCount:UILabel!
    @IBOutlet weak var imgWork:UIImageView!
    @IBOutlet weak var btnDetail:UIView!
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
        lbTitle.text=data.stringValue(key: "month") + "월에 가장 길게 적은 작품은?"
        lbGenre.text=data.stringValue(key: "genre")
        lbWorkTitle.text=data.stringValue(key: "workTitle")
        lbRecordCount.text=data.stringValue(key: "recordCount")
        let imgPath = data.stringValue(key: "imgPath")
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.mostImpressiveEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbGenre.layer.masksToBounds = true
        lbGenre.layer.cornerRadius = lbGenre.frame.height/2
        btnDetail.isUserInteractionEnabled = true
        btnDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender:))))
        changeData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension Dictionary where Key == String, Value == Any {
    func stringValue(key:String) -> String{
        let value = self[key]
        return "\(value ?? "")"
    }
    func intValue(key:String) -> Int {
        let value = self[key] as? Int
        return value ?? 0
    }
}

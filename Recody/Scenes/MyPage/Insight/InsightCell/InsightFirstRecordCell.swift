//
//  InsightFirstRecordCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/01.
//

import UIKit

class InsightFirstRecordCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbNickName:UILabel!
    @IBOutlet weak var lbMonth:UILabel!
    @IBOutlet weak var lbGenre:UILabel!
    @IBOutlet weak var lbWorkTitle:UILabel!
    @IBOutlet weak var imgWork:UIImageView!
    @IBOutlet weak var btnDetail:UIView!
    @IBOutlet weak var cellView: UIView?
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            chageData()
        }
    }
    var eventDelegate: ObservingTableCellEvent?
    func chageData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
        lbNickName.text=data.stringValue(key: "nickName")
        lbMonth.text=data.stringValue(key: "month")
        lbGenre.text=data.stringValue(key: "genre")
        lbWorkTitle.text=data.stringValue(key: "workTitle")
        let imgPath = data.stringValue(key: "imgPath")
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.firstRecordEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbGenre.layer.masksToBounds = true
        lbGenre.layer.cornerRadius = lbGenre.frame.height/2
        btnDetail.isUserInteractionEnabled = true
        btnDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender:))))
        chageData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

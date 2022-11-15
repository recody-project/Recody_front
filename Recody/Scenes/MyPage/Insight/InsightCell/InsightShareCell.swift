//
//  InsightShareCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/01.
//

import UIKit
//8
//공유하기버튼
class InsightShareCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var cellView: UIView?
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    var eventDelegate: ObservingTableCellEvent?
    func changeData() {
    }
    func binding(data: Dictionary<String, Any>) {
        
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.shareEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnShare.layer.masksToBounds = true
        btnShare.layer.cornerRadius = 8
        btnShare.setTitle("이 달의 보고서 공유하기", for: .normal)
        btnShare.titleLabel?.font = .systemFont(ofSize: 14)
        btnShare.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
        btnShare.backgroundColor = UIColor.init(hexString: "#666FC1")
        btnShare.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender: ))))
        changeData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

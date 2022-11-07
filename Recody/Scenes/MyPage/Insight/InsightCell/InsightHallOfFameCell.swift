//
//  InsightHallOfFameCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/01.
//

import UIKit
//5
//명예의전당
class InsightHallOfFameCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbNickName:UILabel!
    @IBOutlet weak var lbMonth:UILabel!
    @IBOutlet weak var imgGold:UIImageView!
    @IBOutlet weak var imgSilver:UIImageView!
    @IBOutlet weak var imgBronze:UIImageView!
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
        let goldImgPath = ""
        let silverImgPath = ""
        let bronzeImgPath = ""
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.hallOfFameEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        chageData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

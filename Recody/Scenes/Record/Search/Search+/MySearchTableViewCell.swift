//
//  MySearchTableViewCell.swift
//  Recody
//
//  Created by 마경미 on 12.10.22.
//

import UIKit
//
//protocol TableViewCellDelegate {
//    func deleteButton(indexPathRow: Int)
//}
enum MySearchTableViewCellEvent: Int {
    case delete = 100
    case select = 101
}
class MySearchTableViewCell: UITableViewCell,ObservingTableCell {
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    var cellView: UIView?
    var eventDelegate: ObservingTableCellEvent?
    func binding(data: Dictionary<String, Any>) {
        self.indexPath = viewmodel!.index
        contentLabel.text = data.stringValue(key: "workName")
    }
    @objc func sendEventToController(sender: UITapGestureRecognizer) {
        //code -> 이벤트 코드
        //index -> cell의 index
        if let tag = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: tag,index:self.indexPath)
        }
        
    }
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var indexPath = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLabel.tag = MySearchTableViewCellEvent.select.rawValue
        contentLabel.isUserInteractionEnabled = true
        contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender: ))))
        deleteButton.tag = MySearchTableViewCellEvent.delete.rawValue
        deleteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender: ))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

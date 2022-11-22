//
//  InsightTop3GenreCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/01.
//

import UIKit
import SnapKit
//4
class InsightTop3GenreCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbTitle:UILabel!
    @IBOutlet weak var svGenre:UIStackView!
    @IBOutlet weak var lbTop1:UILabel!
    @IBOutlet weak var lbTop2:UILabel!
    @IBOutlet weak var lbTop3:UILabel!
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
        lbTop1.text=data.stringValue(key: "top1")
        lbTop2.text=data.stringValue(key: "top2")
        lbTop3.text=data.stringValue(key: "top3")
        
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.top3GenreEvent.rawValue,index: viewmodel!.index)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lbTop1.text = ""
        lbTop2.text = ""
        lbTop3.text = ""
        changeData()
        setupLabels()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func setupLabels(){
        [lbTop1,lbTop2,lbTop3].forEach({
            $0?.textColor = UIColor.init(hexString: "#666FC1")
            $0?.font = .systemFont(ofSize: 12)
            $0?.layer.cornerRadius = self.svGenre.frame.height/2
            $0?.borderColor = UIColor.init(hexString: "#666FC1")
            $0?.borderWidth = 1.0
        })
    }
}

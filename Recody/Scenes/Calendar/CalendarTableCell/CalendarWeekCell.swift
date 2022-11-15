//
//  CalendarWeekCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import UIKit

class CalendarWeekCell: UITableViewCell,ObservingTableCell {
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    @IBOutlet weak var cellView: UIView?
    // 일 1 -> 토 7
    @IBOutlet weak var viewDay1: UIView!
    @IBOutlet weak var viewDay2: UIView!
    @IBOutlet weak var viewDay3: UIView!
    @IBOutlet weak var viewDay4: UIView!
    @IBOutlet weak var viewDay5: UIView!
    @IBOutlet weak var viewDay6: UIView!
    @IBOutlet weak var viewDay7: UIView!
    @IBOutlet weak var lbDayCount1: UILabel!
    @IBOutlet weak var lbDayCount2: UILabel!
    @IBOutlet weak var lbDayCount3: UILabel!
    @IBOutlet weak var lbDayCount4: UILabel!
    @IBOutlet weak var lbDayCount5: UILabel!
    @IBOutlet weak var lbDayCount6: UILabel!
    @IBOutlet weak var lbDayCount7: UILabel!
    @IBOutlet weak var imgWork1: UIImageView!
    @IBOutlet weak var imgWork2: UIImageView!
    @IBOutlet weak var imgWork3: UIImageView!
    @IBOutlet weak var imgWork4: UIImageView!
    @IBOutlet weak var imgWork5: UIImageView!
    @IBOutlet weak var imgWork6: UIImageView!
    @IBOutlet weak var imgWork7: UIImageView!
    
    var weekCount: Int = -1
    var startDayCount: Int = 1
    var endDayCount: Int = 7
    var days = [1,2,3,4,5,6,7]
    var imgs = [1:"",2:"",3:"",4:"",5:"",6:"",7:""]
    var eventDelegate: ObservingTableCellEvent?
    
    func binding(data: Dictionary<String, Any>) {
        guard let data = viewmodel?.data else { return }
        changeData()
    }
    @objc func sendEventToController(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            self.eventDelegate?.eventFromTableCell(code: tag)
        }
    }
    func changeData() {
        for (index,label) in [lbDayCount1, lbDayCount2, lbDayCount3, lbDayCount4, lbDayCount5, lbDayCount6, lbDayCount7].enumerated() {
            label?.text = "\(days[index])"
        }
        settingClick()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func settingClick(){
        for (index,view) in [viewDay1, viewDay2, viewDay3, viewDay4, viewDay5, viewDay6, viewDay7].enumerated(){
            if days[index] > 0 {
                view?.isUserInteractionEnabled = true
                view?.tag = days[index]
                view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender: ))))
            }else {
                view?.isUserInteractionEnabled = false
                if let gestures = view?.gestureRecognizers {
                    gestures.forEach({ it in
                        view?.removeGestureRecognizer(it)
                    })
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

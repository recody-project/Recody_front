//
//  CalendarWeekCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/14.
//

import UIKit

class CalendarWeekCell: UITableViewCell, ObservingTableCell {
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
    var days = [1, 2, 3, 4, 5, 6, 7]
    var imgs = [1: "", 2: "", 3: "", 4: "", 5: "", 6: "", 7: ""]
    var eventDelegate: ObservingTableCellEvent?
    var month = 0
    var year = 0
    func binding(data: Dictionary<String, Any>) {
        if let week = data["week"] as? [Int] {
            self.days = week
        }
        if let month = data["month"] as? Int,
           let year = data["year"] as? Int {
            self.month = month
            self.year = year
        }
        // 오늘날짜를 포함했는지 검사하기위한 플래그
        var isContainToday = false
        var containToday = 0
        if let nowYear = TimeUtil.nowDateComponent().year,
           let nowMonth = TimeUtil.nowDateComponent().month,
           let nowDay = TimeUtil.nowDateComponent().day {
            if year == nowYear && month == nowMonth {
                if self.days.contains(nowDay) {
                    isContainToday = true
                    containToday = nowDay
                }
            }
        }
        let imgWorks = [imgWork1,imgWork2,imgWork3,imgWork4,imgWork5,imgWork6,imgWork7]
        for (index,label) in [lbDayCount1, lbDayCount2, lbDayCount3, lbDayCount4, lbDayCount5, lbDayCount6, lbDayCount7].enumerated() {
            label?.text = "\(days[index])"
            label?.clipsToBounds = true
            if days[index] == -1 {
                label?.isHidden = true
                imgWorks[index]?.isHidden = false
            } else {
                label?.isHidden = false
                imgWorks[index]?.isHidden = false
            }
            if days[index] == containToday {
                label?.layer.cornerRadius = 11
                label?.backgroundColor = UIColor(hexString: "#666FC1")
            }else {
                label?.layer.cornerRadius = 0
                label?.backgroundColor = .clear
            }
        }
        for (index, imgSource) in self.imgs.enumerated() {
            if imgSource.value == "" {
                imgWorks[index]?.isHidden = true
            } else {
                imgWorks[index]?.isHidden = false
            }
        }
        settingClick()
    }
    @objc func sendEventToController(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            self.eventDelegate?.eventFromTableCell(code: tag,index: viewmodel!.index)
        }
    }
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // 날짜가 유효값일때만 액션 이벤트를 등록한다.
    // 유효하지 않을면 (-1) 액션 이벤트를 해제한다.
    func settingClick() {
        for (index,view) in [viewDay1, viewDay2, viewDay3, viewDay4, viewDay5, viewDay6, viewDay7].enumerated() {
            if days[index] > 0 {
                view?.isUserInteractionEnabled = true
                view?.tag = days[index]
                view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEventToController(sender: ))))
            } else {
                view?.isUserInteractionEnabled = false
                if let gestures = view?.gestureRecognizers {
                    gestures.forEach({ gesture in
                        view?.removeGestureRecognizer(gesture)
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

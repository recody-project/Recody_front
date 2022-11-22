//
//  CalendarDetailCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/17.
//

import UIKit

class CalendarDetailCell: UITableViewCell,ObservingTableCell {
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    @IBOutlet weak var cellView: UIView?
    @IBOutlet weak var lbGenre:UILabel!
    @IBOutlet weak var lbWorkTitle:UILabel!
    @IBOutlet weak var imgWork:UIImageView!
    @IBOutlet weak var imgStart1:UIImageView!
    @IBOutlet weak var imgStart2:UIImageView!
    @IBOutlet weak var imgStart3:UIImageView!
    @IBOutlet weak var imgStart4:UIImageView!
    @IBOutlet weak var imgStart5:UIImageView!
    var genre : WorkGenre = .user
    enum WorkGenre : String {
        case movie = "영화"
        case drama = "드라마"
        case music = "음악"
        case show = "공연"
        case book = "책"
        case user = "사용자화"
        var color : UIColor? {
            switch self {
                case .movie:
                    return UIColor(hexString: "#F38A5E")
                case .drama:
                    return UIColor(hexString: "#F6D266")
                case .music:
                    return UIColor(hexString: "#E77D82")
                case .show:
                    return UIColor(hexString: "#89AC5C")
                case .book:
                    return UIColor(hexString: "#3EABB7")
                case .user:
                    return UIColor(hexString: "#666FC1")
            }
        }
    }
    
    var eventDelegate: ObservingTableCellEvent?
    func sendEventToController(sender: UITapGestureRecognizer) {
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.firstRecordEvent.rawValue,index: viewmodel!.index)
        }
    }
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
        lbGenre.text=data.stringValue(key: "genre")
        if let genre = WorkGenre(rawValue: data.stringValue(key: "genre")) {
            self.genre = genre
            lbGenre.backgroundColor = self.genre.color
        }
        lbWorkTitle.text=data.stringValue(key: "workTitle")
        let score = data.intValue(key: "score")
        settingStar(score)
        let imgPath = data.stringValue(key: "imgPath")
    }
    private func settingStar(_ score : Int){
        if score > 10 { return }
        let startImgs = [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5]
        [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5].forEach({
            $0?.image = UIImage(named:"star")
            $0?.image?.withRenderingMode(.alwaysOriginal)
                $0?.tintColor = nil
        })
        var halfStartPosition = -1
        var checkStartLastPosition = -1
        if score%2 == 1 {
            checkStartLastPosition=((score-1)/2) - 1
            halfStartPosition = ((score-1)/2)
        }else{
            checkStartLastPosition=((score)/2) - 1
            halfStartPosition = ((score)/2)
        }
        if checkStartLastPosition != -1 {
            for (index,img) in startImgs.enumerated(){
                if index <= checkStartLastPosition {
                    img?.tintColor = self.genre.color
                }
            }
        }
        if halfStartPosition != -1 {
            startImgs[halfStartPosition]?.image = UIImage(named:"star.half.fill")
            startImgs[halfStartPosition]?.tintColor = self.genre.color
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbGenre.layer.masksToBounds = true
        lbGenre.layer.cornerRadius = lbGenre.frame.height/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

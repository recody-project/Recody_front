//
//  InsightMyRankCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/01.
//

import UIKit
//6
class InsightMyRankCell: UITableViewCell,ObservingTableCell {
    @IBOutlet weak var lbNickName:UILabel!
    @IBOutlet weak var lbMonth:UILabel!
    @IBOutlet weak var lbScoreAverage:UILabel!
    
    @IBOutlet weak var imgStart1:UIImageView!
    @IBOutlet weak var imgStart2:UIImageView!
    @IBOutlet weak var imgStart3:UIImageView!
    @IBOutlet weak var imgStart4:UIImageView!
    @IBOutlet weak var imgStart5:UIImageView!
    @IBOutlet weak var cellView:UIView?
    @IBOutlet weak var chartView:UIView!
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
        let score = data.intValue(key: "score")
        lbScoreAverage.text = "\(Double(score)/2)"
        settingStar(score)
    }
    private func settingStar(_ score : Int){
        if score > 10 { return }
        let startImgs = [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5]
        [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5].forEach({
            $0?.image = UIImage(named:"star")
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
                    img?.image = UIImage(named: "star.fill")
                }
            }
        }
        if halfStartPosition != -1 {
            startImgs[halfStartPosition]?.image = UIImage(named: "star.half.fill")
        }
        
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.myRankEvent.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chageData()
        let chart = CombinChart()
         self.chartView.addSubview(chart)
         chart.snp.makeConstraints({ make in
             make.edges.equalToSuperview()
         })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

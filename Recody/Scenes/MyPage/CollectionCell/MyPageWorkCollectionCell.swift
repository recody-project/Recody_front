//
//  MyPageWorkCollectionCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/28.
//

import UIKit

class MyPageWorkCollectionCell: UICollectionViewCell,ObservingCollectionCell {
    var cellView: UIView?
    var viewmodel:CollectionCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    var eventDelegate: ObservingCollectionCellEvent?
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
//        lbGenre.text=data.stringValue(key: "genre")
//        lbWorkTitle.text=data.stringValue(key: "workTitle")
//        let imgPath = data.stringValue(key: "imgPath")
    }
    @objc func sendEventToController(sender : UITapGestureRecognizer){
        if let code = sender.view?.tag {
//            eventDelegate?.eventFromTableCell(code: InsightCellEvent.allUserMostAppreciationEvent.rawValue,index: viewmodel!.index)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  InsiteViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/27.
//

import Foundation
import UIKit

class InsiteViewController : CommonVC,DataPassingType, ObservingTableCellEvent {
    
    func eventFromTableCell(code: Int) {
        //셀 내의 개별적 제스쳐 이벤트를 처리하는 공간
        //interactor를 통해서 처리
        print(1)
    }
    var viewModel = InsiteViewModel()
    var tableList : [TableCellViewModel] = [TableCellViewModel]()
    
    enum UserCace : Int,OrderType{
        case nextMonth = 101
        case previousMonth = 102
        var number: Int {
            return self.rawValue
        }
    }
    
    enum InsiteCellType : Int {
        case statistics = 1
        case statisticsGraph = 2
        case mostImpressive = 3
        case top3Genre = 4
        case firstRecord = 5
        case hallOfFame = 6
        case myRank = 7
        case mostAppreciation = 8
        case mostAppreciationAll = 9
        case share = 10
        var name : String {
            switch self {
            case .statistics:
                return InsiteStatisticsCell.Name
            case .statisticsGraph:
                return InsiteStatisticsGraphCell.Name
            case .mostImpressive:
                return InsiteMostImpressiveCell.Name
            case .top3Genre:
                return InsiteTop3GenreCell.Name
            case .firstRecord:
                return InsiteFirstRecordCell.Name
            case .hallOfFame:
                return InsiteHallOfFameCell.Name
            case .myRank:
                return InsiteMyRankCell.Name
            case .mostAppreciation:
                return InsiteMostAppreciationCell.Name
            case .mostAppreciationAll:
                return InsiteAllUserMostAppreciationCell.Name
            case .share:
                return InsiteShareCell.Name
            }
        }
    }
    
    @IBOutlet weak var lBNickName:UILabel!
    @IBOutlet weak var lBMonthCount:UILabel!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnPrevious:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    func bind(_ data: DataStoreType) {
        
    }
    func routing(orderNumber : Int){
        if orderNumber == 1 {
            
        } else {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpTableView()
    }
    func setup(){
        
        btnNext.tag = UserCace.nextMonth.number
        btnPrevious.tag = UserCace.previousMonth.number
        [btnNext,btnPrevious].forEach({
            $0?.setTitle("", for: .normal)
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnClickEvent)))
        })
        
    }
    @objc func btnClickEvent(_ sender : UITapGestureRecognizer){
        if let tag = sender.view?.tag {
//            if let command = UserCace.init(rawValue: tag) {
//                self.interactor?.just(command).send(["month":"\(self.viewModel.currentMonth - 1)"])
//            }
        }
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        
    }
    override func displayErorr(orderNumber: Int) {
        
    }
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let registerCellList = [(InsiteStatisticsCell.Xib,
                                 InsiteStatisticsCell.Name),
                                (InsiteStatisticsGraphCell.Xib,
                                 InsiteStatisticsGraphCell.Name),
                                (InsiteMostImpressiveCell.Xib,
                                 InsiteMostImpressiveCell.Name),
                                (InsiteTop3GenreCell.Xib,
                                 InsiteTop3GenreCell.Name),
                                (InsiteFirstRecordCell.Xib,
                                 InsiteFirstRecordCell.Name),
                                (InsiteHallOfFameCell.Xib,
                                 InsiteHallOfFameCell.Name),
                                (InsiteMyRankCell.Xib,
                                 InsiteMyRankCell.Name),
                                (InsiteMostAppreciationCell.Xib,
                                 InsiteMostAppreciationCell.Name),
                                (InsiteAllUserMostAppreciationCell.Xib,
                                 InsiteAllUserMostAppreciationCell.Name),
                                (InsiteShareCell.Xib,
                                 InsiteShareCell.Name)]
        self.tableView.register(cells:registerCellList)
        tableList.append(TableCellViewModel(type: InsiteCellType.statistics.rawValue,
                                            data: ["nickName":"닉네임",
                                                   "month":"9",
                                                   "workCount":"99",
                                                   "recordCount":"999"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.statisticsGraph.rawValue,
                                            data: ["temp":""]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostImpressive.rawValue,
                                            data: ["month":"9",
                                                   "genre":"영화",
                                                   "workTitle":"1987",
                                                   "recordCount":"900"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.top3Genre.rawValue,
                                            data: ["top1":"코미디",
                                                   "top2":"로맨스 코미디",
                                                   "top3":"액션"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.firstRecord.rawValue,
                                            data: ["nickName":"코미디",
                                                   "month":"10",
                                                   "genre":"액션",
                                                   "workTitle":"오만과 편견"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.hallOfFame.rawValue,
                                            data: ["nickName":"영화가젤좋아",
                                                   "month":"9"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.myRank.rawValue,
                                            data: ["nickName":"영화가젤좋아",
                                                   "month":"9",
                                                   "score":9]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostAppreciation.rawValue,
                                            data: ["month":"9",
                                                   "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.mostAppreciationAll.rawValue,
                                            data: ["genre":"영화",
                                                   "workTitle":"1987"]))
        tableList.append(TableCellViewModel(type: InsiteCellType.share.rawValue, data: nil))
        tableView.contentInset.top = 10.0
        tableView.contentInset.bottom = 20.0
        tableView.reloadData()
    }
}

extension InsiteViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = tableList.filter{ $0.visible }.count
        return list
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list = self.tableList.filter{ $0.visible }
        var cell = UITableViewCell()
        
        guard let type = InsiteCellType(rawValue: list[indexPath.row].type) else { fatalError("CellType Int Out Of Bounds Error") }
        var mCell = tableView.dequeueReusableCell(withIdentifier: type.name) as? UITableViewCell & ObservingTableCell
            mCell?.viewmodel = list[indexPath.row]
            mCell?.eventDelegate = self
        
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
        cell.contentView.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let list = self.tableList.filter{ $0.visible }
        return list[indexPath.row].viewHeight
//        return list[indexPath.row].viewHeight + 20
    }
}
struct InsiteViewModel {
    var nickName : String = ""
    var currentMonth : Int = 1
    var seenWorks : Int = 0
    var recordCount : Int = 0
}

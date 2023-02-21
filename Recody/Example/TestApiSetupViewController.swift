//
//  TestApiSetupViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/20.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class TestApiSetupViewController: UIViewController{
    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var btnParam: UIButton!
    @IBOutlet weak var btnMethod: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var container: UIView!
    
    lazy var viewControllers : [UIViewController] = {
        return (0...2).map({ index -> UIViewController in
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            return vc
        })
    }()
    lazy var tableViews : [UITableView] = {
        return (0...1).map({ index -> UITableView in
            let tableview = UITableView()
            tableview.backgroundColor = .white
//            tableview.allowsSelection = false
            if index == 0 {
                tableview.tag = UseCase.param.rawValue
            }
            if index == 1 {
                tableview.tag = UseCase.header.rawValue
            }
            tableview.register(UINib(nibName: "TestApiSetupTableCell", bundle: nil), forCellReuseIdentifier: "TestApiSetupTableCell")
            return tableview
        })
    }()
    lazy var pageVC: PageViewController = {
          let vc = PageViewController()
        vc.view.subviews.forEach({
            if $0 is UIScrollView {
                ($0 as? UIScrollView)?.isScrollEnabled = false
            }
        })
            vc.view.backgroundColor = .white
            vc.view.gestureRecognizers?.forEach({
                vc.view.removeGestureRecognizer($0)
            })
//          vc.view.isUserInteractionEnabled = false
          return vc
    }()
    
    var viewModel = TestApiSetupViewModel()
    enum UseCase : Int {
        case header = 1
        case param = 2
        case method = 3
        case send = 4
        case reset = 5
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnHeader.tag = UseCase.header.rawValue
        btnHeader.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnParam.tag = UseCase.param.rawValue
        btnParam.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnMethod.tag = UseCase.method.rawValue
        btnMethod.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnSend.tag = UseCase.send.rawValue
        btnSend.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnReset.tag = UseCase.reset.rawValue
        btnReset.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        container.backgroundColor = .white
        setupTaps()
        pageVC.add(viewControlers: viewControllers)
            .setUpLayout(viewController: self, superView: container)
              .moveSlidePage()
        setData()
        update()
    }
    func setupTaps(){
        tableViews.forEach({
            $0.delegate = self
            $0.dataSource = self
        })
        for (index,viewcontroller) in viewControllers.enumerated(){
            if index < 2 {
                viewcontroller.view.addSubview(tableViews[index])
                tableViews[index].snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
            } else {
                
            }
            
        }
    }
    func setData(){
        viewModel.params.append(["key1":"value1"])
        viewModel.headers.append(["key1":"value1"])
    }
    func update(){
        tableViews.forEach({
            $0.reloadData()
        })
        [btnParam,btnMethod,btnHeader].forEach({
            $0?.backgroundColor = .darkGray
            $0?.setTitleColor(.blue, for: .normal)
        })
        switch viewModel.tap {
        case .param:
            pageVC.moveSlidePage(index: 0)
            btnParam.backgroundColor = .blue
            btnParam.setTitleColor(.white, for: .normal)
        case .header:
            pageVC.moveSlidePage(index: 1)
            btnHeader.backgroundColor = .blue
            btnHeader.setTitleColor(.white, for: .normal)
        case .method:
            pageVC.moveSlidePage(index: 2)
            btnMethod.backgroundColor = .blue
            btnMethod.setTitleColor(.white, for: .normal)
        }
        
    }
    
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        guard let tag = sender.view?.tag,
              let useCase = UseCase.init(rawValue: tag) else { return }
        switch useCase {
            case .method:
                changeTap(.method)
            case .header:
                changeTap(.header)
            case .param:
                changeTap(.param)
            case .send:
                print("send")
            case .reset:
                print("reset")
        }
    }
    
    func changeTap(_ type:TestApiSetupViewModel.PageType){
        viewModel.tap = type
        update()
    }
    
}
class TestApiSetupViewModel {
    var tap = PageType.param
    var params = [Dictionary<String,String>]()
    var headers = [Dictionary<String,String>]()
    var method = HTTPMethod.post
    var server = ApiClient.server
    enum PageType : Int {
        case header // 1
        case param // 2
        case method
    }
}
extension TestApiSetupViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let useCase = UseCase.init(rawValue: tableView.tag) else { return 0 }
        switch useCase {
        case .header:
            return viewModel.headers.count
        case .param:
            return viewModel.params.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let useCase = UseCase.init(rawValue: tableView.tag) ,
              let cell = tableView.dequeueReusableCell(withIdentifier: "TestApiSetupTableCell") as? TestApiSetupTableCell
        else { return UITableViewCell() }
        cell.delegate = self
        var vm = TestApiSetupTableCellViewModel()
        vm.tapIndex = tableView.tag
        vm.cellIndex = indexPath.row
        if useCase == .header {
            if let dic = viewModel.headers[indexPath.row].first {
                vm.key = dic.key
                vm.value = dic.value
            }
        }else if (useCase == .param){
            if let dic = viewModel.params[indexPath.row].first {
                vm.key = dic.key
                vm.value = dic.value
            }
        }
        cell.setViewModel(vm: vm)
        return cell
    }
}
extension TestApiSetupViewController: TestApiSetupTableCellDelegate {
    func viewModelChaged(viewmodel: TestApiSetupTableCellViewModel) {
        if viewModel.tap == .param {
            viewModel.params[viewmodel.cellIndex] = [viewmodel.key:viewmodel.value]
        }else if(viewModel.tap == .header){
            viewModel.headers[viewmodel.cellIndex] = [viewmodel.key:viewmodel.value]
        }
    }
    func deleteCell(index: Int, tapIndex: Int) {
        if viewModel.tap == .param {
            viewModel.params.remove(at: index)
        }else if(viewModel.tap == .header){
            viewModel.headers.remove(at: index)
        }
        update()
    }
}

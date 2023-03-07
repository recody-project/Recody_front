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

class TestApiSetupViewController: UIViewController {
    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var btnParam: UIButton!
    @IBOutlet weak var btnMethod: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var container: UIView!
    var origin = TestApiSetupViewModel()
    lazy var viewControllers : [UIViewController] = {
        return (0...2).map({ index -> UIViewController in
            if index == 2 {
                let sb = UIStoryboard(name: "TestApi", bundle: nil)
            
                if let vc = sb.instantiateViewController(withIdentifier: "TestApiSettingViewController") as? TestApiSettingViewController{
                    vc.delegate = self
                    return vc
                }else{
                    return UIViewController()
                }
            }else{
                let vc = UIViewController()
                vc.view.backgroundColor = .white
                return vc
            }
            
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
        origin.update(self.viewModel)
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
                if let vc = viewcontroller as? TestApiSettingViewController {
                    vc.viewModel.isPost = viewModel.method == .post
                    vc.viewModel.subDomain = viewModel.subDomain
                    vc.viewModel.isJson = viewModel.encoding is JSONEncoding
                    vc.viewModel.server = ApiClient.server
                }
            }
            
        }
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
            if let vc = UIStoryboard(name: "TestApi", bundle: nil).instantiateViewController(withIdentifier: "TestApiDetailViewController") as? TestApiDetailViewController {
                var request = ApiCellModel(name: viewModel.name,
                             headers: viewModel.headers,
                             params: viewModel.params,
                             subDomain: viewModel.subDomain,
                             encoding: viewModel.encoding)
                request.method = viewModel.method
                vc.viewmodel = TestApiDetailViewModel(request: request)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            case .reset:
                reset()
        }
    }
    func reset(){
        self.viewModel.update(self.origin)
        if let vc = viewControllers.last as? TestApiSettingViewController {
            vc.viewModel.isPost = viewModel.method == .post
            vc.viewModel.subDomain = viewModel.subDomain
            vc.viewModel.isJson = true
            vc.viewModel.server = ApiClient.server
            vc.update()
        }
        update()
    }
    func changeTap(_ type:TestApiSetupViewModel.PageType){
        viewModel.tap = type
        update()
    }
    
}
class TestApiSetupViewModel {
    var name = ""
    var tap = PageType.param
    var params = [Dictionary<String,Any>]()
    var headers = [Dictionary<String,Any>]()
    var method : HTTPMethod
    var server = ""
    var subDomain = ""
    var encoding : ParameterEncoding = JSONEncoding.default
    init(){
        method = HTTPMethod.post
        server = ApiClient.server
        headers = [Dictionary<String,Any>]()
        params = [Dictionary<String,Any>]()
    }
    func update(_ viewModel : TestApiSetupViewModel){
        method = viewModel.method
        subDomain = viewModel.subDomain
        params = viewModel.params
        headers = viewModel.headers
        server = viewModel.server
    }
    
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
            print("header count = \(viewModel.headers.count)")
            return viewModel.headers.count
        case .param:
            print("param count = \(viewModel.params.count)")
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
                vm.value = "\(dic.value)"
            }
        }else if (useCase == .param){
            if let dic = viewModel.params[indexPath.row].first {
                vm.key = dic.key
                vm.value = "\(dic.value)"
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
extension TestApiSetupViewController: TestApiSettingDelegate {
    func dataChanged(viewModel: TestApiSettingViewModel) {
        self.viewModel.method = viewModel.isPost ? HTTPMethod.post : HTTPMethod.get
        self.viewModel.subDomain = viewModel.subDomain
        self.viewModel.encoding = viewModel.isJson ? JSONEncoding.default : URLEncoding.default
    }
}

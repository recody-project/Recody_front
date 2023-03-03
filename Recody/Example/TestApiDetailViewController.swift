//
//  TestApiDetailViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/14.
//

import Foundation
import UIKit
import Alamofire
class TestApiDetailViewController : UIViewController {
    @IBOutlet weak var textView : UITextView!
    var viewmodel : TestApiDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    /***
     TODO
     viewmodel.request.server
     viewmodel.request.Encoding
     */
    func setup(){
        ApiClient.requestTEST(viewmodel.request.headers,
                              viewmodel.request.params,
                              viewmodel.request.subDomain,
                              viewmodel.request.subDomain, viewmodel.request.method,
                              JSONEncoding.default, { data in
            self.viewmodel.content += "ApiName : \(self.viewmodel.request.name) \n"
            if let obj = data.obj {
                self.viewmodel.content += "Response \n"
                self.viewmodel.content += "========== \n"
                obj.forEach({ key,value in
                    self.viewmodel.content += "\(key) : \(value) \n"
                })
                self.viewmodel.content += "========== \n"
                self.update()
            }
        }, { error in
            self.viewmodel.content = ""
            self.viewmodel.content += "통신실패 \n"
            self.viewmodel.content += error
            self.update()
        })
    }
    func update(){
        self.textView.text =  viewmodel.content
    }
}
class TestApiDetailViewModel {
    var request: ApiCellModel
    init(request: ApiCellModel) {
        self.request = request
    }
    var content = ""
}

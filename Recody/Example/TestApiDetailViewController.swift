//
//  TestApiDetailViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/14.
//

import Foundation
import UIKit
class TestApiDetailViewController : UIViewController {
    @IBOutlet weak var textView : UITextView!
    var viewmodel : TestApiDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    func setup(){
        ApiClient.request(command: viewmodel.request.command, { data in
            
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
//            let alert = UIAlertController(title: "알림", message: "\(error)", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "확인", style: .default,handler: { _ in
//                self.navigationController?.popViewController(animated: true)
//            })
//            alert.addAction(ok)
//            self.present(alert, animated: true)
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

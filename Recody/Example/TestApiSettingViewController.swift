//
//  TestApiSettingViewController.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/03/03.
//

import Foundation
import UIKit
class TestApiSettingViewController: UIViewController {
    var viewModel = TestApiSettingViewModel()
    var delegate: TestApiSettingDelegate?
    @IBOutlet weak var lbMethod: UILabel!
    @IBOutlet weak var textServer: UITextField!
    @IBOutlet weak var isMethod: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    func setup(){
        self.viewModel.server = ApiClient.server
        self.textServer.delegate = self
    }
    
    @IBAction func swichValueChanged(_ sender: Any) {
        viewModel.isPost = isMethod.isOn
        update()
    }
    func update(){
        lbMethod.text = viewModel.isPost ? "Method : Post" : "Method : Get"
        textServer.text = viewModel.server
        delegate?.dataChanged(viewModel: viewModel)
    }
}
class TestApiSettingViewModel {
    var server = ""
    var subDomain = ""
    var isPost = true
}
extension TestApiSettingViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.server = textField.text!
        update()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        update()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        update()
    }
}
protocol TestApiSettingDelegate{
    func dataChanged(viewModel:TestApiSettingViewModel)
}

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
    @IBOutlet weak var lbEncoding: UILabel!
    @IBOutlet weak var isJson: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    func setup(){
        self.textServer.delegate = self
        isMethod.tag = 1
        isJson.tag = 2
    }
    
    @IBAction func swichValueChanged(_ sender: Any) {
        if let sw = sender as? UISwitch  {
            let tag = sw.tag
            if tag == 1 {
                viewModel.isPost = isMethod.isOn
            }else if (tag == 2){
                viewModel.isJson = isJson.isOn
            }
        }
        dataChanged()
        update()
    }
    func dataChanged(){
        delegate?.dataChanged(viewModel: viewModel)
    }
    func update(){
        isMethod.setOn(viewModel.isPost, animated: true)
        isJson.setOn(viewModel.isJson, animated: true)
        lbMethod.text = viewModel.isPost ? "Method : Post" : "Method : Get"
        lbEncoding.text = viewModel.isJson ? "Encoding : JSON" : "Encoding : URL"
        textServer.text = viewModel.subDomain
    }
}
class TestApiSettingViewModel {
    var server = ""
    var subDomain = ""
    var isPost = true // method
    var isJson = true // encoding
}
extension TestApiSettingViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.server = textField.text!
        dataChanged()
        update()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dataChanged()
        update()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        dataChanged()
        update()
    }
}
protocol TestApiSettingDelegate{
    func dataChanged(viewModel:TestApiSettingViewModel)
}

//
//  TestApiSetupTableCell.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/02/21.
//

import UIKit

class TestApiSetupTableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var keyText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    var delegate: TestApiSetupTableCellDelegate?
    var viewModel = TestApiSetupTableCellViewModel()
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let tag = textField.tag
        if tag == 1 {
            viewModel.key = textField.text!
        }else if ( tag == 2 ){
            viewModel.value = textField.text!
        }
        delegate?.viewModelChaged(viewmodel: viewModel)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag == 1 {
            valueText.becomeFirstResponder()
        }else if ( tag == 2 ){
            valueText.resignFirstResponder()
        }
        return true
    }
    
    func setViewModel(vm: TestApiSetupTableCellViewModel){
        self.viewModel = vm
        keyText.text = vm.key
        valueText.text = vm.value
        keyText.delegate = self
        valueText.delegate = self
        keyText.tag = 1
        valueText.tag = 2
        
    }
    @objc func deleteBtnClick(_ sender: UITapGestureRecognizer){
        delegate?.deleteCell(index: viewModel.cellIndex,tapIndex: viewModel.tapIndex)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnDelete.setTitle("", for: .normal)
        btnDelete.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteBtnClick)))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
protocol TestApiSetupTableCellDelegate{
    func viewModelChaged(viewmodel :TestApiSetupTableCellViewModel)
    func deleteCell(index: Int, tapIndex:Int)
}
class TestApiSetupTableCellViewModel {
    var key = ""
    var value = ""
    var cellIndex = -1
    var tapIndex = -1
}

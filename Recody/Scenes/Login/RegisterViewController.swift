//
//  RegisterViewController.swift
//  Recody
//
//  Created by 최지철 on 2023/08/02.
//

import UIKit
import RxSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var eyebtn2: UIButton!
    @IBOutlet weak var eyebtn1: UIButton!
    @IBOutlet weak var checkdupliBtb: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var checkpwTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    private let viewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()
    
    private func configure(){
        registerBtn.titleLabel?.textColor = UIColor(hexString: "#373737")
        eyebtn1.setTitle("", for: .normal)
        eyebtn2.setTitle("", for: .normal)

    }
    @IBAction func eyeBtn1Clcik(_ sender: Any) {
        eyebtn1.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    @IBAction func eyeBtn2Click(_ sender: Any) {
        eyebtn2.setImage(UIImage(systemName: "eye"), for: .normal)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.bindViewModel()
    }
    @IBAction func backBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    private func bindViewModel(){
        // Input binding
           viewModel.email.bind(to: emailTextField.rx.text).disposed(by: disposeBag)
           viewModel.password.bind(to: pwTextField.rx.text).disposed(by: disposeBag)
           viewModel.passwordConfirm.bind(to: checkpwTextField.rx.text).disposed(by: disposeBag)

        registerBtn.rx.tap
               .bind(to: viewModel.signUpButtonTapped)
               .disposed(by: disposeBag)

           // Output binding
           viewModel.userInfo
               .subscribe(onNext: { [weak self] userInfo in
                   // Handle userInfo data here (e.g., show success message, navigate to the next screen)
                   print("User Info: \(userInfo)")
               })
               .disposed(by: disposeBag)

           viewModel.error
               .subscribe(onNext: { error in
                   // Handle error here (e.g., show error message)
                   print("Error: \(error)")
               })
               .disposed(by: disposeBag)
    }
}

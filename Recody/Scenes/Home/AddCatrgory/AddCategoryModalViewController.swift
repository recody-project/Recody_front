//
//  AddCategoryModalViewController.swift
//  Recody
//
//  Created by 윤지호 on 2023/08/11.
//

import UIKit
import RxSwift
import RxCocoa

protocol AddCategoryModalViewControllerAttrubute {
    func bind()
    func configure()
}

class AddCategoryModalViewController: UIViewController {
    
    // -1 일 경우 추가 / 0이상일 경우 편집
    var listIndex: Int = 0
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var iconStackView: UIStackView!
    @IBOutlet weak var saveBtn: UIButton!
    
    private var addViewModel = AddCategoryViewModel()
    private let disposeBag = DisposeBag()
    let dataSource = PublishSubject<SampleCategory>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        addViewModel.categotyIndex.onNext(listIndex)
    }

    static func getInstance() -> AddCategoryModalViewController {
        guard let addVC = UIStoryboard(name: "AddCategory", bundle: nil).instantiateViewController(withIdentifier: "AddCategory") as? AddCategoryModalViewController else {
            fatalError()
        }
        return addVC
    }
    
}

extension AddCategoryModalViewController: AddCategoryModalViewControllerAttrubute {
    func bind() {
        let input = AddCategoryViewModel.Input(nameText: nameTextField.rx.text, saveTap: saveBtn.rx.tap)
        let output = addViewModel.transform(from: input)
        
        output.titleText
            .bind(to: titleLable.rx.text)
            .disposed(by: disposeBag)
        
        output.nameText
            .bind(to: addViewModel.nameRelay)
            .disposed(by: disposeBag)
        
        output.isValid
            .drive(saveBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isValid
            .drive { [weak self] isValid in
                self?.setSaveBtn(isValid)
            }
            .disposed(by: disposeBag)
        
        output.iconState
            .bind(onNext: { [weak self] state in
                for idx in 0..<5 {
                    if state == idx {
                        self?.setCategoryColor(self?.iconStackView.arrangedSubviews[idx] as? CustomCategory ?? CustomCategory(), selected: true)
                    } else {
                        self?.setCategoryColor(self?.iconStackView.arrangedSubviews[idx] as? CustomCategory ?? CustomCategory(), selected: false)
                    }
                }
            })
            .disposed(by: disposeBag)
                    
        backBtn.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        cancelBtn.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        saveBtn.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        addViewModel.savedData
            .bind(onNext: dataSource.onNext(_:))
            .disposed(by: disposeBag)
        
    }
    
    func configure() {
        
        // textField
        nameTextField.placeholder = "1~4글자 특수문자 제외"
        
        // Icon Stack View
        iconStackView.distribution = .fillEqually
        
        for idx in 0..<5 {
            let categoryView = CustomCategory()
            categoryView.setRenderedImage(imgName: addViewModel.icons[idx])
            categoryView.categoryName.text = ""
            
            setCategoryColor(categoryView, selected: false)
            
            categoryView.snp.makeConstraints { make in
                make.width.equalTo(56)
            }
            
            let tapGesture = UITapGestureRecognizer()
            categoryView.addGestureRecognizer(tapGesture)
            tapGesture.rx.event
                .bind { [weak self] _ in
                    self?.addViewModel.iconState.accept(idx)
                }
                .disposed(by: disposeBag)
            
            iconStackView.addArrangedSubview(categoryView)
        }
        
    }
    
    private func setCategoryColor(_ sender: CustomCategory, selected: Bool) {
        switch selected {
        case true:
            sender.categoryImage.backgroundColor = UIColor(hexString: "#666FC1")
            sender.categoryImage.tintColor = UIColor.white
        case false:
            sender.categoryImage.backgroundColor = UIColor(hexString: "#F6F6F6")
            sender.categoryImage.tintColor = UIColor(hexString: "#999999")
        }
    }
    
    private func setSaveBtn(_ enable: Bool) {
        switch enable {
        case true:
            saveBtn.backgroundColor = UIColor(hexString: "#373737")
            saveBtn.borderColor = UIColor(hexString: "#373737")
            saveBtn.setTitleColor(.white, for: .normal)
        case false:
            saveBtn.backgroundColor = UIColor.white
            saveBtn.borderColor = UIColor(hexString: "#CECECE")
            saveBtn.setTitleColor(UIColor(hexString: "#CECECE"), for: .normal)
            saveBtn.borderWidth = 1
        }
    }
}

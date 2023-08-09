//
//  EditGenreCollectionViewCell.swift
//  Recody
//
//  Created by 마경미 on 2022/09/13.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class EditGenreCollectionViewCell: UICollectionViewCell {
    static let cellID = "editGenreCollectionViewCell"
    
    let cellDataObs = PublishSubject<SampleCategory.Genre>()
    var button = UIButton()
    
    private let cellDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        button.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        configure()
        bind()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind() {
        cellDataObs.asObserver()
            .bind { [weak self] genre in
                self?.setData(with: genre)
            }
            .disposed(by: cellDisposeBag)
        
        button.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.touchToggleBtn()
            })
            .disposed(by: cellDisposeBag)
    }
    
    func configure() {
        self.addSubview(button)
        button.titleLabel?.font = UIFont.fontWithName(type: .regular, size: 12)
        button.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setData(with data: SampleCategory.Genre) {
        button.setTitle(data.genre, for: .normal)
        button.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        button.setTitleColor(UIColor(hexString: "#F38A5E"), for: .selected)
        button.setBackgroundColor(color: UIColor.white, state: .normal)
        button.setBackgroundColor(color: UIColor(hexString: "#FEF3EF"), state: .selected)
        button.cornerRadius = 6

        if data.isSelected {
            button.borderColor = UIColor(hexString: "#F38A5E")
            button.borderWidth = 2
            button.isSelected = true
        } else {
            button.borderColor = UIColor(hexString: "#CECECE")
            button.borderWidth = 1
            button.isSelected = false
        }
    }
    
    func touchToggleBtn() {
        if button.isSelected {
           button.borderColor = UIColor(hexString: "#CECECE")
            button.borderWidth = 1
            button.isSelected = false
        } else {
            button.borderColor = UIColor(hexString: "#F38A5E")
            button.borderWidth = 2
            button.isSelected = true
        }
    }
}

//
//  AddCategoryViewModel.swift
//  Recody
//
//  Created by 윤지호 on 2023/08/11.
//

import Foundation
import RxCocoa
import RxSwift

class AddCategoryViewModel {
    let disposeBag = DisposeBag()
    
    let icons: [String] = ["star", "mountain", "moon", "sun", "wind"]
    
    // -1일 경우 추가, 0~이상일 경우 편집
    let categotyIndex = BehaviorSubject<Int>(value: -1)
    let savedData = PublishSubject<SampleCategory>()
    let titleRelay = PublishRelay<String>()
    let nameRelay = BehaviorRelay<String>(value: "")
    let iconState = BehaviorRelay<Int>(value: -1)
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(nameRelay, iconState)
            .map { (name, state) in
                return name.count > 0 && name.count < 5 && state > -1 && name.isExcludedSpecialCharacters()
            }
    }
    
    struct Input {
        let nameText: ControlProperty<String?>
        let saveTap: ControlEvent<Void>
    }
    struct Output {
        let titleText: PublishRelay<String>
        let iconState: BehaviorRelay<Int>
        let nameText: ControlProperty<String>
        let isValid: Driver<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let nameText = input.nameText.orEmpty
        let saveBtnTap = input.saveTap
        
        let isValid = isValid.asDriver(onErrorJustReturn: true)
        
        // 추가 - 현재 VC에서 저장
        saveBtnTap
            .withLatestFrom(Observable.combineLatest(nameRelay, iconState, categotyIndex))
            .bind(onNext: { (name, imgidx, idx) in
                if idx < 0 {
                    SampleCategoryManager.getManager.addCategoty(name: name, imageIdx: imgidx)
                }
            })
            .disposed(by: disposeBag)
        
        // 편집 - 이전 VC에서 따로 저장
        saveBtnTap
            .withLatestFrom(Observable.combineLatest(nameRelay, iconState))
            .map { (name, imgIdx) -> SampleCategory in
                let imgStr = SampleCategory.imageStr[imgIdx]
                return SampleCategory(name: name, imageStr: imgStr, genres: [])
            }
            .subscribe(onNext: savedData.onNext(_:))
            .disposed(by: disposeBag)
        
        // 저장된 배열의 index를 통해 받은 데이터들을 View의 textField와 titleLabel, iconImage에 보내줌
        categotyIndex
            .flatMap { idx -> Observable<SampleCategory> in
                if idx > -1 {
                    return SampleCategoryManager.getManager.fetchCategory(index: idx)
                } else {
                    return Observable.just(SampleCategory(name: "", imageStr: "", genres: []))
                }
            }
            .map { [weak self] category -> String in
                if category.name != "" {
                    let imgIndex = SampleCategory.imageStr.firstIndex(where: { $0 == category.imageStr })
                    self?.iconState.accept(imgIndex ?? 0)
                    return category.name
                } else {
                    return ""
                }
            }
            .bind(onNext: nameRelay.accept(_:))
            .disposed(by: disposeBag)
        
        categotyIndex
            .map { idx -> String in
                return idx < 0 ? "카테고리 추가" : "카테고리 편집"
            }
            .bind(onNext: titleRelay.accept(_:))
            .disposed(by: disposeBag)
        
        nameRelay
            .bind(onNext: nameText.onNext(_:))
            .disposed(by: disposeBag)
        
        return Output(titleText: titleRelay,
                      iconState: iconState,
                      nameText: nameText,
                      isValid: isValid)
    }
    
}

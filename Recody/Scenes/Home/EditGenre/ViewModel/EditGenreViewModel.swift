//
//  EditGenreViewModel.swift
//  Recody
//
//  Created by 윤지호 on 2023/08/05.
//

import Foundation
import RxCocoa
import RxSwift

class EditGenreViewModel {
    private let disposeBag = DisposeBag()
    
    var categorys = BehaviorRelay<[SampleCategory]>(value: [])
    let nowState = BehaviorRelay<Int>(value: 0)
    let customCategory = PublishRelay<SampleCategory>()
    let genres = PublishRelay<[SampleCategory.Genre]>()
    let toggleGenre = PublishRelay<Int>()
    
    let save = PublishSubject<Void>()
    
    init(categorys: [SampleCategory] = SampleCategoryManager.getManager.categorys) {
        self.categorys.accept(categorys)
    }
    
    struct Input {
        let nextBtnTapped: ControlEvent<Void>
        let beforeBtnTapped: ControlEvent<Void>
        let saveBtnTapped: ControlEvent<Void>
        let addGenreTapped: ControlEvent<Void>
    }
    
    struct OutPut {
        let customCategory: PublishRelay<SampleCategory>
        let genres: PublishRelay<[SampleCategory.Genre]>
    }
    
    func transform(from input: Input) -> OutPut {
        
        input.saveBtnTapped
            .withLatestFrom(categorys)
            .bind { category in
                SampleCategoryManager.getManager.saveData(categorys: category)
            }
            .disposed(by: disposeBag)

        input.nextBtnTapped
            .withLatestFrom(nowState)
            .map { $0 + 1 }
            .bind(onNext: nowState.accept(_:))
            .disposed(by: disposeBag)

        input.beforeBtnTapped
            .withLatestFrom(nowState)
            .map { $0 - 1 }
            .bind(onNext: nowState.accept(_:))
            .disposed(by: disposeBag)
        
        input.addGenreTapped
            .withLatestFrom(Observable.combineLatest(nowState, categorys))
            .map { (state, categorys) in
                var result = categorys
                let sampleGenre = SampleCategory.Genre(genre: "장르", isSelected: false)
                result[state].genres.append(sampleGenre)
                return result
            }
            .bind(onNext: categorys.accept(_:))
            .disposed(by: disposeBag)
        
        input.addGenreTapped
            .withLatestFrom(nowState)
            .bind(onNext: nowState.accept(_:))
            .disposed(by: disposeBag)
        
        nowState
            .withLatestFrom(Observable.combineLatest(nowState, categorys))
            .map { (index, categorys) -> SampleCategory in
                if index < 0 {
                    self.nowState.accept(categorys.count - 1)
                    return categorys.last!
                } else if index > categorys.count - 1 {
                    self.nowState.accept(0)
                    return categorys[0]
                } else {
                    return categorys[index]
                }
            }
            .subscribe(onNext: customCategory.accept(_:))
            .disposed(by: disposeBag)
        
        toggleGenre
            .withLatestFrom(customCategory) { idx, category in
                var result = category
                result.genres[idx].isSelected.toggle()
                return result
            }
            .bind(onNext: customCategory.accept(_:))
            .disposed(by: disposeBag)
        
        customCategory
            .withLatestFrom(categorys, resultSelector: { category, categorys -> [SampleCategory] in
                let index = categorys.firstIndex(where: { $0.name == category.name})
                var result = categorys
                result[index!] = category
                return result
            })
            .bind(onNext: categorys.accept(_:))
            .disposed(by: disposeBag)
        
        customCategory
            .bind(onNext: { self.genres.accept($0.genres) })
            .disposed(by: disposeBag)
            
        return OutPut(customCategory: customCategory,
                      genres: genres)
    }
}

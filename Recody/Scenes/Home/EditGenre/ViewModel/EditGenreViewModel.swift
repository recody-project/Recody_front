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
    
    let editedCategotySubject = PublishRelay<SampleCategory>()
    
    var categorys = BehaviorSubject<[SampleCategory]>(value: [])
    let nowState = BehaviorRelay<Int>(value: 0)
    let customCategory = PublishRelay<SampleCategory>()
    let genres = PublishRelay<[SampleCategory.Genre]>()
    let editedCategory = PublishRelay<SampleCategory>()
    let toggleGenre = PublishRelay<Int>()
    let save = PublishSubject<Void>()
    
    init(categorys: [SampleCategory] = SampleCategoryManager.getManager.categorys) {
        self.categorys.onNext(categorys)
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
            .withLatestFrom(Observable.combineLatest(nowState, categorys) { (index, categorys) -> Int in
                var index = index + 1
                if index < 0 {
                    index = categorys.count - 1
                } else if index > categorys.count - 1 {
                    index = 0
                }
                print("index =? \(index)")
                return index
            })
            .bind(onNext: nowState.accept(_:))
            .disposed(by: disposeBag)

        input.beforeBtnTapped
            .withLatestFrom(Observable.combineLatest(nowState, categorys) { (index, categorys) -> Int in
                var index = index - 1
                if index < 0 {
                    index = categorys.count - 1
                } else if index > categorys.count - 1 {
                    index = 0
                }
                print("index =? \(index)")
                return index
            })
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
            .bind(onNext: categorys.onNext(_:))
            .disposed(by: disposeBag)
        
        input.addGenreTapped
            .withLatestFrom(nowState)
            .bind(onNext: nowState.accept(_:))
            .disposed(by: disposeBag)
        
        nowState
            .withLatestFrom(categorys) { (index, categorys) -> SampleCategory in
                return categorys[index]
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
        
        editedCategory
            .withLatestFrom(customCategory) { edited, category -> SampleCategory in
                var editedCategory = category
                editedCategory.name = edited.name
                editedCategory.imageStr = edited.imageStr
                return editedCategory
            }
            .bind(onNext: customCategory.accept(_:))
            .disposed(by: disposeBag)
        
        customCategory
            .withLatestFrom(categorys) { category, categorys -> [SampleCategory] in
                let index = categorys.firstIndex(where: { $0.id == category.id })
                var result = categorys
                result[index!] = category
                return result
            }
            .bind(onNext: categorys.onNext(_:))
            .disposed(by: disposeBag)
        
        customCategory
            .bind(onNext: { self.genres.accept($0.genres) })
            .disposed(by: disposeBag)
            
        return OutPut(customCategory: customCategory,
                      genres: genres)
    }
}

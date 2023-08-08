//
//  SampleCategoryManager.swift
//  Recody
//
//  Created by 윤지호 on 2023/08/05.
//

import Foundation
import RxSwift

class SampleCategoryManager {
    static let getManager = SampleCategoryManager()
    
    private init() { }
    
    var categorys = SampleCategory.sampleList
    
    func fetchData() -> Observable<[SampleCategory]> {
        return Observable.just(categorys)
    }
    
    func saveData(categorys: [SampleCategory]) {
        self.categorys = categorys
    }
}

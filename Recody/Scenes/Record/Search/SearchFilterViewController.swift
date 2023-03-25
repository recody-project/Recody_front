//
//  SearchFilterViewController.swift
//  Recody
//
//  Created by 마경미 on 25.03.23.
//

import UIKit

class SearchFilterViewController: UIViewController {
    var viewModel = SearchFilterViewModel()
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
}

extension SearchFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return viewModel.categories.count
        } else {
            return viewModel.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCtaegoryCollectionViewCell.id, for: indexPath) as? FilterCategoryCollectionViewCell else { return UICollectionViewCell() }
        } else {
            guard let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: FilterGenreCollectionViewCell.id, for: indexPath) as? FilterGenreCollectionViewCell else { return UICollectionViewCell() }
        }
    }
    
    
}

class SearchFilterViewModel {
    let categories: [String]
    let genres: [String]
    
    init() {
        categories = ["영화", "드라마", "음악", "공연"]
        genres = ["액션", "모험", "애니메이션", "코미디", "범죄",
                  "다큐멘터리", "드라마", "가족", "판타지", "역사",
                  "공포", "음악", "미스터리", "로맨스", "SF", "TV영화",
                  "스릴러", "전쟁", "서부"]
    }
}

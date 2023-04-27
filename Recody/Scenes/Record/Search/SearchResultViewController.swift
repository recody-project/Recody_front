//
//  SearchResultViewController.swift
//  Recody
//
//  Created by 마경미 on 19.03.23.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchBar
    }
    static func getInstanse() -> SearchResultViewController{
        guard let vc =  UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchResult") as? SearchResultViewController
        else {
            fatalError()
        }
        return vc
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

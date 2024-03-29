//
//  EditGenreViewController.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxCocoa
import RxSwift

protocol EditGenreViewControllerAttribute {
    func bind()
    func configure()
    func setFlowlayout()
}

class EditGenreViewController: UIViewController {
    
    @IBOutlet weak var category: CustomCategory!
    @IBOutlet weak var editCategotyBtn: UIButton!
    @IBOutlet weak var nextCategotyBtn: UIButton!
    @IBOutlet weak var beforeCategotyBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addGenreBtn: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backBarBtn: UIBarButtonItem!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!

    private var editViewModel = EditGenreViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
        setFlowlayout()
    }
    
    static func getInstanse() -> EditGenreViewController {
        guard let eidtVC =  UIStoryboard(name: "CategorySetting", bundle: nil).instantiateViewController(withIdentifier: "CategorySetting") as? EditGenreViewController else {
            fatalError()
        }
        return eidtVC
    }
}

extension EditGenreViewController: EditGenreViewControllerAttribute {
    
    func bind() {
        let input = EditGenreViewModel.Input(nextBtnTapped: nextCategotyBtn.rx.tap,
                                             beforeBtnTapped: beforeCategotyBtn.rx.tap,
                                             saveBtnTapped: saveBarBtn.rx.tap,
                                             addGenreTapped: addGenreBtn.rx.tap)
        
        backBarBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: disposeBag)
        
        saveBarBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: disposeBag)
        
        let output = editViewModel.transform(from: input)
        
        output.customCategory
            .bind { [weak self] item in
                self?.category.setRenderedImage(imgName: item.imageStr)
                self?.category.categoryImage.tintColor = UIColor.white
                self?.category.categoryName.text = item.name
                self?.category.setInEditView()
            }
            .disposed(by: disposeBag)
        
        output.genres
            .bind(to: collectionView.rx.items(cellIdentifier: EditGenreCollectionViewCell.cellID, cellType: EditGenreCollectionViewCell.self)) { index, item, cell in
                
                cell.cellDataObs.onNext(item)
                
                cell.button.rx.tap
                    .subscribe(onNext: { [weak self] in
                        self?.editViewModel.toggleGenre.accept(index)
                    }).disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        editViewModel.nowState.accept(0)
    }
    
    func configure() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationBar.shadowImage = UIImage()
        navigationBar.topItem?.title = "편집"
        
        // CustomCategory
        let tapGesture = UITapGestureRecognizer()
        category.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .withLatestFrom(editViewModel.nowState)
            .bind { [weak self] idx in
                let addCategoryView = AddCategoryModalViewController.getInstance()
                addCategoryView.listIndex = idx
                addCategoryView.modalPresentationStyle = .custom
                addCategoryView.transitioningDelegate = self
                addCategoryView.dataSource
                    .bind(onNext: (self?.editViewModel.editedCategory.accept(_:))!)
                    .disposed(by: self!.disposeBag)
                self?.present(addCategoryView, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setFlowlayout() {
        let flowlayout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 2
        let cellWidth = (width) / itemsPerRow
        flowlayout.itemSize = CGSize(width: cellWidth - 20, height: 46)
        collectionView.collectionViewLayout = flowlayout
    }
}

extension EditGenreViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

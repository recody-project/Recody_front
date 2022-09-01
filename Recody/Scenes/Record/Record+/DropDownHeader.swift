//
//  DropDownHeader.swift
//  Recody
//
//  Created by 마경미 on 2022/09/01.
//

import UIKit
import DropDown

class DropDownHeader: UICollectionReusableView {
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!

    let dropdown = DropDown()
    let itemList = ["item1", "item2", "item3", "item4", "item5", "item6"]

    func initUI() {
        dropView.layer.cornerRadius = 8
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        itemLabel.text = "감상일 순" // 힌트 텍스트
        ivIcon.tintColor = UIColor.gray
    }

    func setDropdown() {
        // dataSource로 ItemList를 연결
        dropdown.dataSource = itemList
        // anchorView를 통해 UI와 연결
        dropdown.anchorView = self.dropView
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        // Item 선택 시 처리
        dropdown.selectionAction = { [weak self] (_, item) in
            self!.itemLabel.text = item
            self!.ivIcon.image = UIImage(systemName: "arrowtriangle.down.fill")        }
        // 취소 시 처리
        dropdown.cancelAction = { [weak self] in
            self!.ivIcon.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    }

    @IBAction func dropdownClicked(_ sender: UIButton) {
        dropdown.show() // 아이템 팝업을 보여준다.
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        self.ivIcon.image = UIImage(systemName: "arrowtriangle.up.fill")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        initUI()
        setDropdown()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
        initUI()
        setDropdown()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        initUI()
        setDropdown()
    }

    func xibSetup() {
        guard let view = loadViewFromNib(nib: "DropDownHeader") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UICollectionReusableView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UICollectionReusableView
    }
}

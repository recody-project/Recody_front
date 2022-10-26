//
//  SampleViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/25.
//

import Foundation
import UIKit

class SampleViewController: CommonVC,DataPassingType {
    func bind(_ data: DataStoreType) {
        if let bindingData = data.data(SomeOrder.new)?.fetch(ChildDataModel.self) {

        } else {

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

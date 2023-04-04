//
//  UILabel+.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/04.
//

import Foundation
import UIKit

extension UILabel{
    func setUnderline() {
        guard let labelText = self.text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        let dic = [NSAttributedString.Key.underlineStyle: 1]
        attributedString.addAttributes(dic, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

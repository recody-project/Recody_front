//
//  String+.swift
//  Recody
//
//  Created by Snuh_Mobile on 2023/04/05.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let str = self
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}$"
            let pred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return pred.evaluate(with: str)
    }
    
    func isExcludedSpecialCharacters() -> Bool {
        let str = self
        let regEx = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{0,}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: str)
    }
}

//
//  StarRatingSlider.swift
//  Recody
//
//  Created by 마경미 on 24.09.22.
//

import Foundation
import UIKit

class StarRatingSlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let fPercent = tapPoint.x/width
        let nNewValue = self.maximumValue * Float(fPercent)
        if nNewValue != self.value {
            self.value = nNewValue
        }
        return true
    }
}

//
//  RoutingEvent.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation
import UIKit

enum RoutingLogic: RoutingLogicType {
    enum Navigation: NavigationType {
        case home
        case record
        case workDetailInfo
        var viewcontroller: UIViewController? {
            switch self {
            case .home:
                return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "home")
            case .record:
                return RecordViewController()
            case .workDetailInfo:
                return WorkDetailInfoViewController()
            }
        }
    }

    enum Segment: SegmentType {
        case home
        case record
        case workDetailInfo
        var segue: UIStoryboardSegue? {
            switch self {
            case .home:
           
                return nil
            default:
                return nil
            }
        }
    }
}

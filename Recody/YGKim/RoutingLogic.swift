//
//  RoutingEvent.swift
//  Recody
//
//  Created by Glory Kim on 2022/10/20.
//

import Foundation
import UIKit

enum RoutingLogic {
    enum Navigation {
        case home
        case record
        case workDetailInfo
        var viewcontroller : UIViewController? {
            switch self {
                case .home:
                    return HomeViewController()
                case .record:
                    return RecordViewController()
                case .workDetailInfo:
                    return WorkDetailInfoViewController()
                default:
                    return nil
            }
        }
    }
    enum Segment {
        case home
        case record
        case workDetailInfo
        var segue : UIStoryboardSegue? {
            switch self {
                default:
                    return nil
            }
        }
       
    }
}

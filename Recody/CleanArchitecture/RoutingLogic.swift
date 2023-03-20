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
        case insight
        case record
        case setting
        case workDetailInfo
        case calendarDetail
        case calendarSetting
        case modifyProfile // 마이페이지 -> 프로필 수정 화면
        case recordList
        case categorySetting
        case addRecord
        case searchResult
        var viewcontroller: UIViewController? {
            switch self {
            // UIStoryboard( 스토리보드 파일명 )
            // .instantiateViewController(withIdentifier: 스토리보드ID )
            case .home:
                return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "home")
            case .insight:
                return UIStoryboard(name: "Insight", bundle: nil).instantiateViewController(withIdentifier: "insight")
            case .record:
                return RecordViewController()
            case .setting:
                return UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "setting")
            case .workDetailInfo:
                return UIStoryboard(name: "WorkDetailInfo", bundle: nil).instantiateViewController(withIdentifier: "workDetailInfo")
            case .calendarDetail:
                return UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarDetailViewController")
            case .calendarSetting:
                return UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarSettingViewController")
            case .modifyProfile:
                return UIStoryboard(name: "ModifyProfile", bundle: nil).instantiateViewController(withIdentifier: "modifyProfile")
            case .recordList:
                return UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "listView")
            case .categorySetting:
                return UIStoryboard(name: "CategorySetting", bundle: nil).instantiateViewController(withIdentifier: "CategorySetting")
            case .addRecord:
                return UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "addRecord")
            case .searchResult:
                return UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchResult")
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

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
        case main
        case login
        case loginEmail
        case registerMember
        case home
        case insight
        case insightMonthReport // insight -> 타이틀 햄버거 버튼으로 접근
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
        case testApi // 테스트 api
        case notification
        var viewcontroller: UIViewController? {
            switch self {
            // UIStoryboard( 스토리보드 파일명 )
            // .instantiateViewController(withIdentifier: 스토리보드ID )
            case .main:
//                TabBarController.getInstanse()
                return UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController()
            case .login:
//                LoginViewController.getInstanse()
                return UIStoryboard(name: "login", bundle: nil).instantiateInitialViewController()
            case .loginEmail:
//                EmailLoginViewController.getInstanse()
                return UIStoryboard(name: "EmailLogin", bundle: nil).instantiateInitialViewController()
            case .registerMember:
//                RegisterMemberViewController.getInstanse()
                return UIStoryboard(name: "registerMember", bundle: nil).instantiateInitialViewController()
            case .home:
//                HomeViewController.getInstanse()
                return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "home")
            case .insight:
//                InsightViewController.getInstanse()
                return UIStoryboard(name: "Insight", bundle: nil).instantiateViewController(withIdentifier: "insight")
            case .insightMonthReport:
//                InsightViewController.getInstanse()
                let vc = UIStoryboard(name: "Insight", bundle: nil).instantiateViewController(withIdentifier: "monthReport")
                return vc
            case .record:
//                RecordViewController.getInstanse()
                return RecordViewController()
            case .setting:
//                SettingViewController.getInstanse()
                return UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "setting")
            case .workDetailInfo:
//                WorkDetailInfoViewController.getInstanse()
                return UIStoryboard(name: "WorkDetailInfo", bundle: nil).instantiateViewController(withIdentifier: "workDetailInfo")
            case .calendarDetail:
//                CalendarDetailViewController.getInstanse()
                return UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarDetailViewController")
            case .calendarSetting:
//                CalendarSettingViewController.getInstanse()
                return UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarSettingViewController")
            case .modifyProfile:
//                ModifyProfileViewController.getInstanse()
                return UIStoryboard(name: "ModifyProfile", bundle: nil).instantiateViewController(withIdentifier: "modifyProfile")
            case .recordList:
//                ListViewController.getInstanse()
                return UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "listView")
            case .categorySetting:
//                EditGenreViewController.getInstanse()
                return UIStoryboard(name: "CategorySetting", bundle: nil).instantiateViewController(withIdentifier: "CategorySetting")
            case .addRecord:
//                SearchViewController.getInstanse()
                return UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "addRecord")
            case .searchResult:
//                SearchResultViewController.getInstanse()
                return UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchResult")
            case .testApi:
//                TestApiViewController.getInstanse()
                return UIStoryboard(name: "TestApi", bundle: nil).instantiateViewController(withIdentifier: "TestApiViewController")
            case .notification:
//                NotificationViewController.getInstanse()
                return UIStoryboard(name: "Notification", bundle: nil).instantiateViewController(withIdentifier: "notification")
            }
        }
    }

    enum Segment {
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

//
//  TabBar.swift
//  Recody
//
//  Created by 마경미 on 2022/08/08.
//

import UIKit

class TabBarController: UITabBarController {

//    let viewController1 = HomeViewController()
//    let viewController3 = CalendarViewController()
//    let viewController4 = MyPageViewController()
//
//    tabBarController.setViewControllers([viewController1,
//                         viewController2,
//                         UIViewController()),
//                         viewController4], animated: true)
    private var previousTabIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
        guard let items = tabBar.items else { return }
        for (index, tabBarItem) in items.enumerated() where tabBarItem == item {
        // viewController3의 index는 2입니다!
            if index == 1 {
            // 이전 인덱스로 화면 전환!
                selectedIndex = previousTabIndex
                            
           // viewController3 push!
                let baseNavigationController = UIApplication.shared.keyWindow?.rootViewController
                print(baseNavigationController)
//                baseNavigationController.pushViewController(SearchViewController, animated: true)
            } else {
            // 그 외의 화면들은 인덱스 업데이트!
                previousTabIndex = index
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

}

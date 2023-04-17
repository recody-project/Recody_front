//
//  TabBar.swift
//  Recody
//
//  Created by 마경미 on 2022/08/08.
//

import UIKit

class TabBarController: UITabBarController {
    public var previousTabIndex: Int = 0
    
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
                selectedIndex = previousTabIndex
                            
                let baseNavigationController = UIApplication.shared.keyWindow?.rootViewController
            } else {
                previousTabIndex = index
            }
        }
    }
}

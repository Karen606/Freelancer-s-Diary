//
//  TabBarController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(named: "ButtonColor")

    }
    override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            if let customTabBar = tabBar as? CustomTabBar {
                customTabBar.setNeedsLayout()
                customTabBar.layoutIfNeeded()
            }
        }
        
        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if let customTabBar = tabBar as? CustomTabBar {
                customTabBar.setNeedsLayout()
                customTabBar.layoutIfNeeded()
            }
        }
}

import UIKit

import UIKit

import UIKit

class CustomTabBar: UITabBar {
    
    private let whiteLine = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        whiteLine.removeFromSuperview()
        
        addSubview(whiteLine)
        
        whiteLine.backgroundColor = .white
        whiteLine.frame.size.height = 4
        whiteLine.layer.cornerRadius = 2
        if let selectedItemIndex = items?.firstIndex(of: selectedItem ?? UITabBarItem()) {
            let itemWidth = self.frame.width / CGFloat(items?.count ?? 1)
            whiteLine.frame.size.width = itemWidth
            whiteLine.frame.origin.x = itemWidth * CGFloat(selectedItemIndex)
            if let iconImage = items?[selectedItemIndex].image {
                let iconHeight = iconImage.size.height
                let tabBarHeight = self.frame.height
                whiteLine.frame.origin.y = (tabBarHeight - iconHeight) - whiteLine.frame.height
            }
        }
    }
}

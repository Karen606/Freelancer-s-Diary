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
}

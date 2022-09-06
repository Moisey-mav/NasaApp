//
//  TabBarViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateCustomTabBar()
    }
    
    private func generateCustomTabBar() {
        generateItems()
        settingsCustom()
    }
    
    private func generateItems() {
        let camerasVC = UINavigationController(rootViewController: CamerasViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        viewControllers = [
            generateVC(viewController: camerasVC, title: "Камеры", image: UIImage(named: "cameras-icon")),
            generateVC(viewController: settingsVC, title: "Настройки", image: UIImage(named: "settings-icon"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func settingsCustom() {
        self.tabBar.tintColor = UIColor(named: "CustomPurple")
        self.tabBar.backgroundColor = .white
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.unselectedItemTintColor = UIColor(named: "CustomBlack")
    }
}

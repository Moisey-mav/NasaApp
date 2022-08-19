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
        settingsTabBar()
    }
    
    private func settingsTabBar() {
        setupVC()
        settingsCustomTabBar()
    }
    
    private func setupVC() {
        let camersVC = CamerasViewController()
        let navCamersRootVC = UINavigationController(rootViewController: camersVC)
        camersVC.title = "Камеры"
        let settingsVC = SettingsViewController()
        let navSettingsRootVC = UINavigationController(rootViewController: settingsVC)
        settingsVC.title = "Настройки"
        
        let controllersArray = [navCamersRootVC, navSettingsRootVC]
        self.setViewControllers(controllersArray, animated: true)
        setupImageTabBar()
    }
    
    private func setupImageTabBar() {
        guard let items = self.tabBar.items else { return }
        let image = ["cams","settings"]
        for x in 0...1 {
            items[x].image = UIImage(named: image[x])
        }
    }
    
    private func settingsCustomTabBar() {
        self.tabBar.tintColor = UIColor(named: "CustomPurple")
        self.tabBar.backgroundColor = .white
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.unselectedItemTintColor = UIColor(named: "CustomBlack")
    }
}

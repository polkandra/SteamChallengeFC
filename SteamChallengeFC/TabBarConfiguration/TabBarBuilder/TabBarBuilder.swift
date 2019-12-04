//
//  TabBarBuilder.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

final class TabBarBuilder {
    
    private let controllersFabric: ControllersFabric
    
    init(controllerFabric: ControllersFabric) {
        self.controllersFabric = controllerFabric
    }
    
    func buildTabBarViewController() -> MainTabBarController {
        let tabBarController = controllersFabric.createMainTabBar()
        return tabBarController
    }
}

//MARK: UserProfileViewController
extension TabBarBuilder {
    func buildUserProfileViewController() -> UserProfileViewController {
        let viewController = controllersFabric.createUserProfileViewController()
        let img = UIImage(named: "profile")
        let tabTitle = "Профиль"
        return buildTabViewController(viewController: viewController,
                                      tabTitle: tabTitle,
                                      img: img,
                                      selectedImg: nil) as! UserProfileViewController
    }
}

//MARK: LastPlayedSessionsViewController
extension TabBarBuilder {
    func buildLastPlayedSessionsViewController() -> LastPlayedSessionsViewController {
        let viewController = controllersFabric.createLastPlayedSessionsViewController()
        let img = UIImage(named: "played")
        let tabTitle = "Сессии"
        return buildTabViewController(viewController: viewController,
                                      tabTitle: tabTitle,
                                      img: img,
                                      selectedImg: nil) as! LastPlayedSessionsViewController
    }
}

//MARK: Configurations for each tab view controller
extension TabBarBuilder {
    private func buildTabViewController(viewController: UIViewController,
                                        tabTitle: String?,
                                        img: UIImage?,
                                        selectedImg: UIImage?) -> UIViewController {
        
        viewController.tabBarItem = UITabBarItem(title: tabTitle,
                                                 image: img,
                                                 selectedImage: selectedImg)
      
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

        return viewController
    }
}

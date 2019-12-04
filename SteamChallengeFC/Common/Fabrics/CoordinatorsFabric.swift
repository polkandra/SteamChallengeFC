//
//  CoordinatorsFabric.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol CoordinatorsFabric {
    func createTabBarCoordinator() -> (Coordinator, Presentable)
    func createProfileCoordinator(tabBarController: UITabBarController) -> Coordinator
    func createLastPlayedSessionsCoordinator(tabBarController: UITabBarController) -> Coordinator
}

final class CoordinatorsFabricImp: CoordinatorsFabric {
    func createTabBarCoordinator() -> (Coordinator, Presentable) {
        let tabBar = TabBarBuilder(controllerFabric: ControllersFabricImp()).buildTabBarViewController()
        let tabBarCoordinator = TabBarCoordinator(tabbarController: tabBar, coordinatorsFabric: CoordinatorsFabricImp())
        return (tabBarCoordinator, tabBar)
    }
    
    func createProfileCoordinator(tabBarController: UITabBarController) -> Coordinator {
        let profileCoordinator = UserProfileCoordinatorImp(tabBarController: tabBarController, controllerFabric: ControllersFabricImp(), coordinatorFabric: CoordinatorsFabricImp(), networkManager: NetworkManager())
        return profileCoordinator
    }
    
    func createLastPlayedSessionsCoordinator(tabBarController: UITabBarController) -> Coordinator {
        let lastPlayedSessionsCoordinator = LastPlayedSessionsCoordinatorImp(tabBarController: tabBarController, controllerFabric: ControllersFabricImp(), coordinatorFabric: CoordinatorsFabricImp(), networkManager: NetworkManager())
        return lastPlayedSessionsCoordinator
    }
}


//
//  LastPlayedSessionsCoordinator.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol LastPlayedSessionsCoordinator {
    
}

class LastPlayedSessionsCoordinatorImp: BaseCoordinator {
    private var router: AppRouter?
    private var controllersFabric: ControllersFabric
    private let coordinatorsFabric: CoordinatorsFabric
    private let tabBarController: UITabBarController
    private var networkManager: NetworkManager
    
    init(tabBarController: UITabBarController,
         controllerFabric: ControllersFabric,
         coordinatorFabric: CoordinatorsFabric,
         networkManager: NetworkManager) {
        
        self.controllersFabric = controllerFabric
        self.coordinatorsFabric = coordinatorFabric
        self.tabBarController = tabBarController
        self.networkManager = networkManager
    }
    
    override func start() {
        let lastPlayedSessionsViewController = TabBarBuilder(controllerFabric: controllersFabric).buildLastPlayedSessionsViewController()
        let presenter = LastPlayedSessionsPresenterImp(coordinator: self, controller: lastPlayedSessionsViewController, client: NetworkManager())
        lastPlayedSessionsViewController.presenter = presenter
        let navController = UINavigationController(rootViewController: lastPlayedSessionsViewController)
        router = AppRouterImp(rootController: navController)
        tabBarController.viewControllers?.append(navController)
    }
}

extension LastPlayedSessionsCoordinatorImp: LastPlayedSessionsCoordinator {
    
}

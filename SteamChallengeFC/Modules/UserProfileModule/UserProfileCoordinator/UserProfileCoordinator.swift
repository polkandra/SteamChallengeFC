//
//  UserProfileCoordinator.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol UserProfileCoordinator {
    
}

class UserProfileCoordinatorImp: BaseCoordinator {
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
        let profileController = TabBarBuilder(controllerFabric: controllersFabric).buildUserProfileViewController()
        let presenter = UserProfilePresenterImp(coordinator: self, controller: profileController, client: networkManager)
        profileController.presenter = presenter
        let navController = UINavigationController(rootViewController: profileController)
        router = AppRouterImp(rootController: navController)
        tabBarController.setViewControllers([navController], animated: true)
    }
}

extension UserProfileCoordinatorImp: UserProfileCoordinator {
    
}

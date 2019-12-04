//
//  TabBarCoordinator.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    private let tabBarController: MainTabBarController
    private let coordinatorFabric: CoordinatorsFabric
    
    init(tabbarController: MainTabBarController, coordinatorsFabric: CoordinatorsFabric) {
        self.tabBarController = tabbarController
        self.coordinatorFabric = coordinatorsFabric
    }
    
    override func start() {
        runProfileFlow()
        runLastPlayedSessionsFlow()
    }
    
    private func runProfileFlow() {
        let coordinator = coordinatorFabric.createProfileCoordinator(tabBarController: tabBarController)
        coordinator.start()
        addDependency(coordinator)
    }
    
    private func runLastPlayedSessionsFlow() {
        let coordinator = coordinatorFabric.createLastPlayedSessionsCoordinator(tabBarController: tabBarController)
        coordinator.start()
        addDependency(coordinator)
    }
}


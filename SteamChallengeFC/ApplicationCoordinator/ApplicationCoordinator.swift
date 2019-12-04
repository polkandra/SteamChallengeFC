//
//  ApplicationCoordinator.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorsFabric
    private var window: UIWindow?
    private var launchInstructor = LaunchInstructor.configure()
    
    init(window: UIWindow?, coordinatorFactory: CoordinatorsFabric) {
        self.coordinatorFactory = coordinatorFactory
        self.window = window
    }
    
    override func start() {
        switch launchInstructor {
        case .authorization: runAuthFlow()
        case .mainProfile: runMainFlow()
        }
    }
    
    private func runAuthFlow() {
        /*let (coordinator, controller) = self.coordinatorFactory.onBoardingCoordinator()
         coordinator.finishFlow = { [weak self, weak coordinator]  in
         guard let unwrappedSelf =  self else { return }
         UserDefaultsManager.isOnboardingCompleted = true
         unwrappedSelf.launchInstructor = LaunchInstructor.configure(onBoardingWasShow: true, isGoodsCountShow: true)
         unwrappedSelf.removeDependency(coordinator)
         unwrappedSelf.start()
         }
         
         let navController = UINavigationController(rootViewController: controller)
         let router = RouterImp(rootController: navController)
         coordinator.router = router
         coordinator.controller = controller
         addDependency(coordinator)
         coordinator.start()
         window?.rootViewController = navController
         window?.makeKeyAndVisible()*/
    }
    
    private func runMainFlow() {
        let (coordinator, controller) = coordinatorFactory.createTabBarCoordinator()
        window?.rootViewController = controller.toPresent()
        window?.makeKeyAndVisible()
        addDependency(coordinator)
        coordinator.start()
    }
}

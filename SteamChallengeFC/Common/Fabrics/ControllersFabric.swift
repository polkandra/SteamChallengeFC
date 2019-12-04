//
//  ControllersFabric.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol ControllersFabric {
    func createMainTabBar() -> MainTabBarController
    func createUserProfileViewController() -> UserProfileViewController
    func createLastPlayedSessionsViewController() -> LastPlayedSessionsViewController
}

final class ControllersFabricImp: ControllersFabric {
    
    func createMainTabBar() -> MainTabBarController {
        return MainTabBarController()
    }
    
    func createUserProfileViewController() -> UserProfileViewController {
        return UserProfileViewController(nibName: String(describing: UserProfileViewController.self), bundle: nil)
    }
    
    func createLastPlayedSessionsViewController() -> LastPlayedSessionsViewController {
        return LastPlayedSessionsViewController(nibName: String(describing: LastPlayedSessionsViewController.self), bundle: nil)
    }
}

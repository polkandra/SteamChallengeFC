//
//  UserProfilePresenter.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation

protocol UserProfilePresenter {
    
}

class UserProfilePresenterImp: UserProfilePresenter {
    private let coordinator: UserProfileCoordinator
    private weak var controller: UserProfileViewControllerType?
    private let client: NetworkManager!
    
    init(coordinator: UserProfileCoordinator, controller: UserProfileViewControllerType?, client: NetworkManager) {
        self.coordinator = coordinator
        self.controller = controller
        self.client = client
    }
}

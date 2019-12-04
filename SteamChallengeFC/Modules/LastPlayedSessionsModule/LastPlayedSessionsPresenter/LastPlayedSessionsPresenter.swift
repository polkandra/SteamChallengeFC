//
//  LastPlayedSessionsPresenter.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation

protocol LastPlayedSessionsPresenter {
    
}

class LastPlayedSessionsPresenterImp: LastPlayedSessionsPresenter {
    private let coordinator: LastPlayedSessionsCoordinator
    private weak var controller: LastPlayedSessionsViewControllerType?
    private let client: NetworkManager!
    
    init(coordinator: LastPlayedSessionsCoordinator, controller: LastPlayedSessionsViewControllerType?, client: NetworkManager) {
        self.coordinator = coordinator
        self.controller = controller
        self.client = client
    }
}

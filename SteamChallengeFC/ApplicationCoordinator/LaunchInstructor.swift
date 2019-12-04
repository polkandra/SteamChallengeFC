//
//  LaunchInstructor.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation

fileprivate var isLoggedIn = true
//UserDefaultsManager.isLoggedIn ?? true

enum LaunchInstructor {
    case authorization
    case mainProfile
    
    static func configure(loggedIn: Bool = isLoggedIn) -> LaunchInstructor {
        switch (loggedIn) {
        case false: return .authorization
        case true: return .mainProfile
        }
    }
}

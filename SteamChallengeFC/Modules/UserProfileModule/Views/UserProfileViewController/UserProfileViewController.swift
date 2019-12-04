//
//  UserProfileViewController.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol UserProfileViewControllerType: AnyObject {
    
}

class UserProfileViewController: UIViewController {

    var presenter: UserProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Профиль"
    }

}

extension UserProfileViewController: UserProfileViewControllerType {
    
}

//
//  LastPlayedSessionsViewController.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol LastPlayedSessionsViewControllerType: AnyObject {
    
}

class LastPlayedSessionsViewController: UIViewController {
    
    var presenter: LastPlayedSessionsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Сессии"
       
    }
    
}

extension LastPlayedSessionsViewController: LastPlayedSessionsViewControllerType {
    
}

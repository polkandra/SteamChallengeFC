//
//  MainTabBarController.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        UITabBar.appearance().backgroundImage = UIImage.colorForTabBar(color: UIColor.white)
        UITabBar.appearance().shadowImage = UIImage.colorForTabBar(color: UIColor.blue.withAlphaComponent(0.10))
        tabBar.isTranslucent = false
        tabBar.alpha = 1.0
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.blue
        tabBar.unselectedItemTintColor = UIColor.gray
        delegate = self
    }
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = self.tabBar.items?.firstIndex(of: item) else { return }
        let subView = tabBar.subviews[index + 1].subviews.first as! UIImageView
        self.performSpringAnimation(imgView: subView)
    }
    
    //MARK: func to perform spring animation on imageview
    private func performSpringAnimation(imgView: UIView) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {

            imgView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
           
            UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.identity
            })
        })
    }

    func animateTabBarBadgeView(tabItem: Int) {
        loopThroughViews(view: self.tabBar, tabItem: tabItem, iteration: 0)
    }
    
    private func loopThroughViews(view: UIView, tabItem: Int, iteration: Int) {
        for subview in (view.subviews) {
            let viewType = String(describing: type(of: subview))
            print(viewType)
            if viewType == "_UIBadgeView" {
                //performSpringAnimation(imgView: subview)
            } else {
                loopThroughViews(view:subview, tabItem: tabItem, iteration: iteration + 1)
            }
        }
    }
}



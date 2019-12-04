//
//  Router.swift
//  SteamChallengeFC
//
//  Created by Michael on 03.12.2019.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol AppRouter {
    var rootController: UINavigationController? { get }
    func addChildOverNavController(_ controller: Presentable)
    func addChildOverViewController(_ controller: Presentable)
    func addBottomSheetView(_ controller: Presentable)
    func remove(_ childController: Presentable)
    func present(_ controller: Presentable?)
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ controller: Presentable?)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    func pushSpecial(controller: Presentable?, animated: Bool)
    func popController()
    func popController(transition: UIViewControllerAnimatedTransitioning?)
    func popController(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func popToController(_ controller: Presentable?, animated: Bool)
    func dismissController()
    func dismissController(animated: Bool, completion: (() -> Void)?)
    func setRootController(_ controller: Presentable?)
    func setRootController(_ controller: Presentable?, hideBar: Bool)
    func popToRootController(animated: Bool)
}

final class AppRouterImp: NSObject, AppRouter {
    
    weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?
    
    init(rootController: UINavigationController?) {
        self.rootController = rootController
        completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func remove(_ childController: Presentable) {
        childController.toPresent()?.removeFromParent()
        childController.toPresent()?.view.removeFromSuperview()
    }
    
    func addChildOverViewController(_ controller: Presentable) {
        if let controller = controller.toPresent(), let visibleViewController = rootController?.topViewController {
            visibleViewController.addChild(controller)
            controller.view.frame = visibleViewController.view.bounds
            visibleViewController.view.addSubview(controller.view)
        }
    }
    
    func addBottomSheetView(_ controller: Presentable) {
        if let controller = controller.toPresent(), let visibleViewController = rootController?.topViewController {
            visibleViewController.addChild(controller)
            visibleViewController.view.addSubview(controller.view)
            controller.didMove(toParent: visibleViewController)
            
            // 3- Adjust bottomSheet frame and initial position.
            let height = visibleViewController.view.frame.height
            let width  = visibleViewController.view.frame.width
            controller.view.frame = CGRect(x: 0,y: visibleViewController.view.frame.maxY, width: width,height: height)
        }
    }
    
    func addChildOverNavController(_ controller: Presentable) {
        if let viewController = controller.toPresent(), let rootController = rootController {
            rootController.addChild(viewController)
            viewController.view.frame = rootController.view.bounds
            rootController.view.addSubview(viewController.view)
        }
    }
    
    func present(_ controller: Presentable?)  {
        present(controller, transition: nil)
    }
    
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        
        self.present(controller, transition: transition, animated: true)
    }
    
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        guard let controller = controller?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func pushSpecial(controller: Presentable?, animated: Bool) {
        guard let controller = controller?.toPresent() else { return }
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        rootController?.view.window!.layer.add(transition, forKey: kCATransition)
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func dismissController() {
        dismissController(animated: true, completion: nil)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ controller: Presentable?)  {
        push(controller, transition: nil)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(controller, transition: transition, animated: true)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        push(controller, transition: transition, animated: animated, completion: nil)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = controller?.toPresent(), (controller is UINavigationController == false) else { return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popController() {
        popController(transition: nil)
    }
    
    func popController(transition: UIViewControllerAnimatedTransitioning?) {
        popController(transition: transition, animated: true)
    }
    
    func popController(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popToController(_ controller: Presentable?, animated: Bool) {
        if let controllers = self.rootController?.viewControllers , let module = controller {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    func setRootController(_ controller: Presentable?) {
        setRootController(controller, hideBar: false)
    }
    
    func setRootController(_ controller: Presentable?, hideBar: Bool) {
        guard let controller = controller?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootController(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension AppRouterImp: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}

extension AppRouterImp: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}


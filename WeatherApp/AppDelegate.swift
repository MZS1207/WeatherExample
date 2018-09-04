//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/25/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var mainTabBarController : UITabBarController?
    private let networkReachable     = Reachability()
    let locationManager              = CoreLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupReachability()
        setupLocationTracking()
        FirebaseApp.configure()
        
        return true
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        locationManager.checkStatus()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        locationManager.checkStatus()
    }
    
}
extension AppDelegate {
    private func handleOfflineStatus(isReachable : Bool){
        switch isReachable {
        case false:
            let offlineController = NetworkOfflineViewController.controllerFromStoryboard(.excepetions)
            let navController    = navigationController(rootViewController: offlineController)
            mainTabBarController = window?.rootViewController as? UITabBarController
            window?.rootViewController = navController
        default:
            guard let navController = window?.rootViewController as? UINavigationController else { return }
            navController.removeFromParentViewController()
            window?.rootViewController = mainTabBarController
        }
    }
    private func handleLocationOffStatus(isLocationOff: Bool){
        switch isLocationOff {
        case true:
            let locationController = LocationOffViewController.controllerFromStoryboard(.excepetions)

            if let topController = UIApplication.topViewController() {
                if topController is LocationOffViewController {
                    return
                }
                topController.present(locationController, animated: true, completion: nil)
            }
        default:
            if let topController = UIApplication.topViewController(){
                if topController is LocationOffViewController {
                    topController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
extension AppDelegate {
    private func setupReachability(){
        networkReachable?.whenReachable = { [weak self] _  in
            mainThread {
                self?.handleOfflineStatus(isReachable: true)
            }
        }
        networkReachable?.whenUnreachable = { [weak self] _ in
            mainThread {
                self?.handleOfflineStatus(isReachable: false)
            }
        }
        do {
            try networkReachable?.startNotifier()
        } catch {
            Logger.debug("Unable to start reachability")
        }
    }
    private func setupLocationTracking(){
        locationManager.whenLocationDisable = { [weak self] in
            self?.handleLocationOffStatus(isLocationOff: true)
        }
        locationManager.whenLocationEnable = { [weak self] in
            self?.handleLocationOffStatus(isLocationOff: false)
        }
        locationManager.checkStatus()
    }
    private func navigationController(rootViewController : UIViewController)->UINavigationController{
        let nav =  UINavigationController(rootViewController: rootViewController)
        nav.isNavigationBarHidden = true
        return nav
    }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

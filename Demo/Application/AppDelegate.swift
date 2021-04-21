//
//  AppDelegate.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//

import UIKit
import RxSwift
import Toast_Swift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Instance of `UIWindow`
    var window: UIWindow?
    /// Instance of `AppCoordinator`
    fileprivate var appCoordinator: AppCoordinator!
    /// AppDelegate's `DisposeBag`
    fileprivate let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initThirdPartyLibraries()
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!)
        AppDelegate.currentDelegate.showRootScreen()

        return true
    }

    /**
     Function to initialize third party libraries
     */
    func initThirdPartyLibraries() {
        // Initalize IQKeyboardManager
        IQKeyboardManager.shared.enable = true
    }

}
extension AppDelegate {
    // AppDelegate instance for access from other classes
    static var currentDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // UIWindow instance for access from other classes
    static var currentWindow: UIWindow {
        return currentDelegate.window!
    }
        
    // Loader start
    static func startLoading() {
        getCurrentViewController()?.view.isUserInteractionEnabled = false
        getCurrentViewController()?.view.makeToastActivity(.center)
    }
    
    // Loader finish
    static func finishLoading() {
        getCurrentViewController()?.view.isUserInteractionEnabled = true
        getCurrentViewController()?.view.hideToastActivity()
    }
    
    // Get current view controller instance
    static func getCurrentViewController() -> UIViewController? {
        return UIApplication.topViewController()
    }
    
    // Show Toast
    static func showToast(message: String, isLong: Bool = false) {
        if isLong {
            getCurrentViewController()?.view.makeToast(message, duration: 3.0)
        } else {
            getCurrentViewController()?.view.makeToast(message)
        }
    }
    
    /**
     Function to show root screen
     */
    func showRootScreen() {
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }

}

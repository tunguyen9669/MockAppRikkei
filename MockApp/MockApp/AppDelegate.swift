//
//  AppDelegate.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let shared :AppDelegate = AppDelegate()

    var window: UIWindow?
    var tabbar: CustomTabbarController?
    
    public func getTabbar() -> CustomTabbarController {
        return self.tabbar ?? CustomTabbarController()
    }
    
    func createTabbarControler() -> CustomTabbarController {
        let tabbarController = CustomTabbarController()
        tabbarController.tabBar.tintColor = UIColor.blueColor
        
        guard let homeVC = R.storyboard.home.homeViewController(),
            let nearVC = R.storyboard.near.nearViewController(),
            let browseVC = R.storyboard.browse.browseViewController(),
            let myPageVC = R.storyboard.myPage.myPageViewController()
            else {
                return tabbarController
                
        }
        
        homeVC.title = "Home"
        let homeTitle = "Home"
        nearVC.title = "Near"
        let nearTitle = "Near"
        browseVC.title = "Browse"
        let browseTitle = "Browse"
        myPageVC.title = "My Page"
        let myPageTitle = "My page"
        
        homeVC.tabBarItem = UITabBarItem(title: homeTitle.uppercased(), image: R.image.home()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.home_selected()?.withRenderingMode(.alwaysOriginal))
        nearVC.tabBarItem = UITabBarItem(title: nearTitle.uppercased(), image: R.image.near()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.near_selected()?.withRenderingMode(.alwaysOriginal))
        browseVC.tabBarItem = UITabBarItem(title: browseTitle.uppercased(), image: R.image.browse()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.browse_selected()?.withRenderingMode(.alwaysOriginal))
        myPageVC.tabBarItem = UITabBarItem(title: myPageTitle.uppercased(), image: R.image.user()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.user_selected()?.withRenderingMode(.alwaysOriginal))
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let nearNav = UINavigationController(rootViewController: nearVC)
        let browseNav = UINavigationController(rootViewController: browseVC)
        let myPageNav = UINavigationController(rootViewController: myPageVC)
        homeNav.navigationBar.isHidden = true
        nearNav.navigationBar.isHidden = true
        browseNav.navigationBar.isHidden = true
        myPageNav.navigationBar.isHidden = true
        
        
        tabbarController.viewControllers = [homeNav, nearNav, browseNav, myPageNav]
        
        tabbarController.delegate = self
        
        return tabbarController
    }
    
    func moveToHome(){
        self.tabbar = self.createTabbarControler()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabbar
        self.window?.makeKeyAndVisible()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        moveToHome()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let nav = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController {
            nav.popToRootViewController(animated: false)
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("select item: \(viewController.title)")
    }
}


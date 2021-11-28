//
//  AppDelegate.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 28/11/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
//        let wireframe = SearchWireframe()
//        window?.rootViewController = wireframe.search
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        window?.rootViewController = vc
        
        //Make this scene's window visible
        window?.makeKeyAndVisible()
        return true
    }
}

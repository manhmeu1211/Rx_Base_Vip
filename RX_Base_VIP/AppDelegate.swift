//
//  AppDelegate.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = self.window ?? UIWindow()

        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        }
        
        self.window = window
        
        BaseApplication.shared.configMainInterface(in: window)

        window.makeKeyAndVisible()
      
        return true
    }
}


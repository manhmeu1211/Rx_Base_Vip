//
//  BaseApplicationNavigator.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import UIKit
import RXVIPArchitechture

protocol BaseApplicationNavigatorType: NavigatorType, RXVIPMakeHome, RXVIPMakeIntro {
    
}

struct BaseApplicationNavigator: BaseApplicationNavigatorType {
    func makeViewController() -> UIViewController {
        let homeNavigator = makeIntro()
        return homeNavigator.makeViewController()
    }
}

extension BaseApplicationNavigator {
    var isFirstTimeLaunch: Bool {
        let defaults = UserDefaults.standard
        let wasFirstTime = defaults.bool(forKey: Constants.firstTimeLaunchApp)
        return !wasFirstTime
    }
    
    func markFirstTimeLaunched() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Constants.firstTimeLaunchApp)
    }
}

//
//  IntroNavigator.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import RXVIPArchitechture

protocol RXVIPIntroNavigatorType: NavigatorType, Pushable {
    func homeNavigator() -> RXVIPHomeNavigatorType
}

protocol RXVIPMakeIntro {
    func makeIntro() -> RXVIPIntroNavigatorType
}

extension RXVIPMakeIntro {
    func makeIntro() -> RXVIPIntroNavigatorType {
        return RXVIPIntroNavigator()
    }
}

extension RXVIPIntroNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = RXVIPIntroViewModel(navigator: self)
        let viewController = RXVIPIntroViewController(viewModel: viewModel)
        return viewController
    }
    
    func homeNavigator() -> RXVIPHomeNavigatorType {
        return RXVIPHomeNavigator()
    }
}

struct RXVIPIntroNavigator: RXVIPIntroNavigatorType {
}

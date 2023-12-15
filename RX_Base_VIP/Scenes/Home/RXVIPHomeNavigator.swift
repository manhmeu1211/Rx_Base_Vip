// 
//  RXVIPHomeNavigator.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import RXVIPArchitechture

protocol RXVIPHomeNavigatorType: NavigatorType {
}

protocol RXVIPMakeHome {
    func makeHome() -> RXVIPHomeNavigatorType
}

extension RXVIPMakeHome {
    func makeHome() -> RXVIPHomeNavigatorType {
        return RXVIPHomeNavigator()
    }
}

struct RXVIPHomeNavigator: RXVIPHomeNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = RXVIPHomeViewModel(navigator: self)
        let viewController = RXVIPHomeViewController(viewModel: viewModel)
        return viewController
    }
}

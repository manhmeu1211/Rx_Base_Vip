//
//  UIViewController+Rx.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import RXVIPArchitechture
import MBProgressHUD
import UIKit
import RxSwift
import RxCocoa
import Platform

public enum AppState: Equatable {
    case active
    case inactive
    case background
    case terminated
}

public extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showAlert(message: error.localizedDescription)
        }
    }
    
    var popView: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popViewController(animated: true)
        }
    }
    
    var dismiss: Binder<Void> {
        return Binder(base) { viewController, _ in
            viewController.dismiss(animated: true)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            let view: UIView = viewController.view
            viewController.showLoading(forView: view, isLoading: isLoading)
        }
    }
    
//    var isCustomizedLoading: Binder<Bool> {
//        return Binder(base) { viewController, isLoading in
//            let view: UIView = viewController.view
//            viewController.showCustomLoading(for: view, isLoading: isLoading)
//        }
//    }
//    
//    var isCustomizedRemoveBGLoading: Binder<Bool> {
//        return Binder(base) { viewController, isLoading in
//            let view: UIView = viewController.view
//            viewController.showLoadingRemoveBG(for: view, isLoading: isLoading)
//        }
//    }
    
    var applicationDidBecomeActive: Observable<Void> {
        return NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .map { _ in return }
    }
    
    var applicationDidEnterBackground: Observable<Void> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in  return }
    }
    
    var pushable: Binder<Pushable> {
        return Binder(base) { viewController, pushable in
            guard let navigation = viewController.navigationController
            else { return }
            pushable.push(to: navigation)
        }
    }
    
    var pushableViewController: Binder<UIViewController> {
        return Binder(base) { viewController, pushable in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.pushViewController(pushable, animated: true)
        }
    }
    
    var popOver: Binder<PopOver> {
        return Binder(base) { viewController, popOver in
            if let topMost = UIApplication.getTopMostViewController() {
                popOver.present(from: topMost)
            } else {
                popOver.present(from: viewController)
            }
        }
    }
    
    var popViewController: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popViewController(animated: true)
        }
    }
    
    var popToRootViewController: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popToRootViewController(animated: true)
        }
    }
}

public extension Reactive where Base: UIViewController {
    var viewOneTimeAppearTrigger: Driver<Void> {
        return sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
    }
    
    var didLayoutSubviews: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
    }
    
    var viewHasSize: Driver<Void> {
        return didLayoutSubviews
            .startWith(())
            .observe(on: MainScheduler.instance)
            .filter { [weak base] in
                guard let base = base else { return false }
                return base.view.frame != .zero
            }
            .take(1)
            .asDriverOnErrorJustComplete()
    }
}

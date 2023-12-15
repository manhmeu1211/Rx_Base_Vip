//
//  UIViewController+.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import MBProgressHUD
import UIKit

public extension UIViewController {
    func logDeinit() {
        debugPrint(String(describing: type(of: self)) + " deinit")
    }
    
    func showWarning(
        title: String? = nil,
        message: String? = nil,
        titleButtonDone: String? = nil,
        titleButtonCancel: String? = nil,
        messageColor: UIColor? = nil,
        isCancel: Bool = false,
        completionOkAction: (() -> Void)? = nil,
        completionCancelActon: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title ?? "Alert",
                                          message: message,
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: titleButtonDone ?? "Ok",
                                         style: .destructive) { _ in
                completionOkAction?()
            }
            
            alert.addAction(okAction)
            
            if isCancel {
                let cancelAction = UIAlertAction(title: titleButtonCancel ?? "Cancel",
                                                 style: .cancel) { _ in
                    completionCancelActon?()
                }
                alert.addAction(cancelAction)
                
            }
            
            present(alert, animated: true, completion: nil)
        }

    func showAlert(message: String, titleButtonDone: String? = nil, completion: (() -> Void)? = nil) {
        showWarning(
            title: "Alert",
            message: message,
            titleButtonDone: titleButtonDone,
            completionOkAction: {
                completion?()
            })
    }
    
    func showToast(message: String,
                   seconds: Double,
                   textColor: UIColor? = nil,
                   backgroundColor: UIColor? = nil,
                   completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
    
    func showLoading(forView view: UIView, isLoading: Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
            if isLoading {
                let hud = MBProgressHUD.showAdded(to: view, animated: true)
                hud.bezelView.style = .solidColor
            } else {
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    func showCustomLoading(for view: UIView, isLoading: Bool) {
        if isLoading {
            let hud = MBProgressHUD.forView(view) ?? MBProgressHUD.showAdded(to: view, animated: false)
            hud.mode = .customView
            hud.bezelView.style = .solidColor
            hud.label.textColor = .text
            hud.label.font = .font(.medium, withSize: .size12)
            hud.label.text = "Loading..."
            hud.contentColor = .text
            hud.bezelView.backgroundColor = .clear
            
            let loadingView = EBLoadingView()
            var backgroundView: UIView
            if #available(iOS 14, *) {
                backgroundView = EBBlurView()
                hud.backgroundView.subviews {
                    backgroundView
                }
                backgroundView.fillContainer()
            } else {
                hud.backgroundColor = .black.withAlphaComponent(0.5)
            }
            
            hud.customView = loadingView
            hud.show(animated: false)
            loadingView.startLoading()
        } else {
            MBProgressHUD.hide(for: view, animated: false)
        }
    }
    
    func showLoadingRemoveBG(for view: UIView, isLoading: Bool) {
        if isLoading {
            let hud = MBProgressHUD.forView(view) ?? MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .customView
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = .clear
            
            let loadingView = EBRemoveBGLoadingView()
            
            hud.customView = loadingView
            hud.show(animated: true)
            loadingView.loadingView.startLoading()
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}

extension UIViewController {
    public var topMostPresentingViewController: UIViewController {
        var viewController = self
        while let presentingViewController = viewController.presentedViewController {
            viewController = presentingViewController
        }
        return viewController
    }
}

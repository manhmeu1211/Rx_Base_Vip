//
//  UIView+Apperance.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import Stevia
import UnitImageLayerEditor
import UnitAlert

extension UIView {
    public static func configAppearance() {
        let shadowColor = UIColor.barShadow
        let barShadowCIImage = CIImage(color: CIColor(color: shadowColor))
            .cropped(to: CGRect(
                origin: .zero,
                size: CGSize(width: 10, height: 1))
            )
        let shadowImage = UIImage(ciImage: barShadowCIImage)
        
        let tabbar = UITabBar.appearance()
        tabbar.style {
            $0.tintColor = .accent
            $0.isTranslucent = false
            $0.barTintColor = .background
            $0.unselectedItemTintColor = .text
        }
        
        let toolBar = UIToolbar.appearance()
        toolBar.style {
            $0.tintColor = .accent
            $0.isTranslucent = false
            $0.barTintColor = .toolBarColor
            $0.setShadowImage(shadowImage, forToolbarPosition: .bottom)
        }
        
        UINavigationBar.appearance().style {
            $0.barStyle = .black
            $0.prefersLargeTitles = false
            $0.tintColor = .text
            $0.setBackgroundImage(UIImage(), for: .default)
            $0.shadowImage = UIImage()
            $0.barTintColor = .accent
            $0.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.text,
                .font: UIFont.font(.bold, withSize: .size20)
            ]
        }
        
        if #available(iOS 13.0, *) {
            let buttonAppearance = UIBarButtonItemAppearance().with {
                $0.highlighted.titleTextAttributes = [.foregroundColor: UIColor.text]
                $0.normal.titleTextAttributes = [.foregroundColor: UIColor.text]
                $0.focused.titleTextAttributes = [.foregroundColor: UIColor.text]
                $0.disabled.titleTextAttributes = [.foregroundColor: UIColor.text]
            }
            
            let navigationBarApperance = UINavigationBarAppearance().with {
                $0.backgroundColor = .background
                $0.shadowImage = UIImage()
                $0.backgroundEffect = UIBlurEffect(style: .dark)
                $0.buttonAppearance = buttonAppearance
            }
            
            UINavigationBar.appearance().standardAppearance = navigationBarApperance
        }
        
        UILabel
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.textColor = .text
            }
        
        UITableView
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.backgroundColor = .clear
            }
        
        UITableViewCell
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.backgroundColor = .clear
            }
        
        UICollectionView
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.backgroundColor = .clear
            }
        
        UICollectionViewCell
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.backgroundColor = .clear
            }
        
        UIImageView
            .appearance(whenContainedInInstancesOf: [EBViewController.self])
            .style {
                $0.tintColor = .text
            }
        
        UISlider
            .appearance()
            .style {
                $0.tintColor = .text
                $0.thumbTintColor = .text
                $0.minimumTrackTintColor = .text
            }
    }
}

extension UIView {
    public static func configEditorAppearence() {
        IGOverlayEditView.appearance().style {
            $0.closeButtonImage = UIImage.named("ic_delete_layer")
            $0.resizeButtonImage = UIImage.named("ic_resize_layer")
            $0.rotationButtonImage = UIImage.named("ic_rotation_layer")
            $0.tintColor = .accent
            $0.setButtonBorder(width: 0)
            $0.frameCornerRadius = 4
            $0.frameBorderWidth = 1.64
            $0.setBorderDraggingEnable(true)
        }
        
        //        UNLLayersEditorManager.applicationRootFolder = BBFileManager.rootFolder
    }
}

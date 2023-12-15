//
//  UIBarButtonItem.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit

public extension UIBarButtonItem {
    static var flexibleSpaceButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }
    
    static var backButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .named("go_back")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: nil, action: nil)
    }
    
    static var saveButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .named("save_project")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: nil, action: nil)
    }
    
    static var listButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .named("list_layers")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: nil, action: nil)
    }
}

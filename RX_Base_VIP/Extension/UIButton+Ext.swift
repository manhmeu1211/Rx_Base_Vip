//
//  UIButton+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit

public extension UIButton {
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        guard let color = color
        else {
            setBackgroundImage(nil, for: state)
            return
        }
        let image = CIImage(color: CIColor(color: color))
            .cropped(to: CGRect(x: 0, y: 0, width: 1, height: 1))
        let uiImage = UIImage(ciImage: image)
        
        setBackgroundImage(uiImage, for: state)
    }
    
    static var backButton: UIButton {
        let button = UIButton(type: .system)
        button.frame = .init(x: 0, y: 0, width: 50, height: 50)
        button.setImage(.named("go_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    static var saveButton: UIButton {
        let button = UIButton(type: .system)
        button.frame = .init(x: 0, y: 0, width: 50, height: 50)
        button.setImage(.named("save_project")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    static var layersListButton: EBBadgeButton {
        let button = EBBadgeButton(icon: (.named("list_layers")?.withRenderingMode(.alwaysOriginal))!)
        button.frame = .init(x: 0, y: 0, width: 50, height: 50)
        return button
    }
}

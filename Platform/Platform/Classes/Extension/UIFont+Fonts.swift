//
//  UIFont+Fonts.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit


extension UIFont {
    public static func font(_ weight: AppFontWeight,
                     withSize fontSize: AppFontSize = .size12) -> UIFont {
        
        return weight.font.withSize(fontSize.value)
    }
}

extension UIFont {
    public func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [
      UIFontDescriptor.TraitKey.weight: weight]
    ])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
}

public enum AppFontSize: CGFloat {
    case size40
    case size32
    case size24
    case size22
    case size20
    case size18
    case size16
    case size14
    case size12
    case size10
    
    public var value: CGFloat {
        switch self {
        case .size24:
            return 24
        case .size22:
            return 22
        case .size20:
            return 20
        case .size18:
            return 18
        case .size16:
            return 16
        case .size14:
            return 14
        case .size12:
            return 12
        case .size10:
            return 10
        case .size40:
            return 40
        case .size32:
            return 32
        }
    }
}

public enum AppFontWeight: Int {
    case regular
    case bold
    case semiBold
    case medium
    case regularItalic
    
    public var name: String {
        switch self {
        case .regular:
            return "SFProDisplay-Regular"
        case .bold:
            return "SFProDisplay-Bold"
        case .semiBold:
            return "SFProDisplay-Semibold"
        case .medium:
            return "SFProDisplay-Medium"
        case .regularItalic:
            return "SFProDisplay-RegularItalic"
        }
    }
    
    public var font: UIFont {
        return FontsManager.shared.appFonts
            .first { $0.fontName == name }!
    }
}

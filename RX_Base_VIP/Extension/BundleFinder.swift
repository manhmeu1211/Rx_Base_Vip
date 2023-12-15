//
//  R.TypeAlias.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import UIKit

class EditorBaseBundle {
    static let assetBundle: Bundle = {
        let bundle = Bundle(for: EditorBaseBundle.self)
        let bundleUrl = bundle.url(forResource: "", withExtension: "bundle")!
        let assetBundle = Bundle(url: bundleUrl)!
        return assetBundle
    }()
}

struct Color {
    static func named(_ name: String,
                      compatibleWith traitCollection: UITraitCollection? = nil) -> UIColor? {
        return UIColor(named: name,
                       in: EditorBaseBundle.assetBundle,
                       compatibleWith: traitCollection)
    }
}

public struct Image {
    public static func named(_ name: String,
                      compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage? {
        return  UIImage(
            named: name,
            in: EditorBaseBundle.assetBundle,
            compatibleWith: traitCollection)
    }
}

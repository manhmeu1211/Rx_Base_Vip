//
//  FontsManager.swift
//  Platform
//
//  Created by Luong Manh on 15/12/2023.
//


import UIKit

class FontBundle {
    static let bundle: Bundle = {
        let bundle = Bundle(for: FontBundle.self)
        let fontsURL = bundle.url(forResource: "Fonts", withExtension: "bundle")!
        let fontsBundle = Bundle(url: fontsURL)!
        return fontsBundle
    }()
}

class FontsManager {
    static let shared = FontsManager()
    var allFonts: [UIFont] { appFonts + systemFonts }
    let appFonts: [UIFont]
    let customFonts: [UIFont]
    let systemFonts: [UIFont]
    
    init() {
        appFonts = FontsManager.registerFonts()
        customFonts = Self.registerFonts(in: "custom_fonts")
        
        var appFontsName = appFonts
            .map({ $0.fontName })
        
        appFontsName.append(contentsOf: customFonts
            .map({ $0.fontName }))
        
        systemFonts = UIFont.allFonts
            .filter({ !appFontsName.contains($0.fontName) })
    }
    
    static var defaultFontSize = UIFont.systemFontSize
    
    private static func registerFonts(in folder: String = "fonts") -> [UIFont] {
        guard let fontsFolder = FontBundle.bundle.url(forResource: folder, withExtension: nil)
        else { return [] }
        let fileManager = FileManager.default
        
        let fontFiles = ((try? fileManager.contentsOfDirectory(atPath: fontsFolder.path)) ?? [])
            .map({ fontsFolder.appendingPathComponent($0) })
        
        let fonts = fontFiles
            .compactMap({ loadFont(url: $0) })
            .compactMap({ UIFont(name: $0, size: defaultFontSize) })
        
        return fonts
    }
    
    private static func loadFont(url fontURL: URL) -> String? {
        guard
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else {
            return nil
        }
        
        CTFontManagerRegisterGraphicsFont(font, nil)
        
        return font.postScriptName as String?
    }
}

extension UIFont {
    static let allFonts: [UIFont] = {
        var fonts: [UIFont] = []
        let familyNames = UIFont.familyNames
        for family in familyNames {
            fonts.append(contentsOf: UIFont.fontNames(forFamilyName: family)
                .compactMap({ UIFont(name: $0, size: UIFont.systemFontSize) }))
        }
        return fonts
        
    }()
}

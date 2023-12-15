//
//  UIImage+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit

extension UIImage {
    static func named(_ name: String, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage? {
        return Image.named(name, compatibleWith: traitCollection)
    }
}

extension UIImage {
    public func resize(to targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.scale = 1
        // Actually do the resizing to the rect using the ImageContext stuff
        return UIGraphicsImageRenderer(bounds: rect, format: renderFormat).image { _ in
            self.draw(in: rect)
        }
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        self.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
//        UIGraphicsEndImageContext()
//        
//        return newImage
    }
}

public extension CGSize {
    var ratio: CGFloat {
        return width / height
    }
}

public extension UIImage {
    var filledRect: Bool {
        debugPrint("Dectecting filled rect image")
        guard let cgImage = resize(to: .init(width: 100, height: 100)).cgImage,
              let pixelData = cgImage.dataProvider?.data else { return false }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let bytesPerRow = bytesPerPixel * width
        
        var minX = width
        var minY = height
        var maxX: Int = 0
        var maxY: Int = 0
        
        let threshold: CGFloat = 4
        
        let thresholdRect = CGRect(
            x: threshold,
            y: threshold,
            width: CGFloat(width) - threshold * 2,
            height: CGFloat(height) - threshold * 2)
        
        guard thresholdRect.width > 0, thresholdRect.height > 0 else { return true }
        
        for x in 0 ..< width {
            for y in 0 ..< height {

                let pixelInfo = (width + Int(x)) * bytesPerPixel
                let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
                
//                let i = bytesPerRow * Int(y) + bytesPerPixel * Int(x)
//                let a = CGFloat(data[i + 3]) / 255.0
                let coord = CGPoint(x: x - 1, y: y - 1)
                if a <= 0, thresholdRect.contains(coord) {
                    return false
                }
                if(a>0) {
                    if (x < minX) { minX = x };
                    if (x > maxX) { maxX = x };
                    if (y < minY) { minY = y};
                    if (y > maxY) { maxY = y};
                }
            }
        }
        
        return true
//        return minX == width && minY == height && maxX == 0 && maxY == 0
    }
}

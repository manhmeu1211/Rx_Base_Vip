//
//  FileManager.swift
//  Platform
//
//  Created by Luong Manh on 15/12/2023.
//


import Foundation
import UIKit
import RxSwift
import RxCocoa

public class BaseFileManager {
    static let bundle: Bundle = Bundle(for: BaseFileManager.self)
    public static var rootFolder: URL {
        let rootFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return rootFolderPath
    }
    
    static let bundleName = "Platform.bundle"
    
    static let assetBundle: Bundle = {
        let bundle = Bundle(for: BaseFileManager.self)
        let bundleUrl = bundle.url(forResource: bundleName, withExtension: nil)!
        let assetBundle = Bundle(url: bundleUrl)!
        return assetBundle
    }()
    
    static func resourcePath(for fileName: String) -> String? {
        let bundle = self.assetBundle
        
        var components = fileName.components(separatedBy: "/")
        if let index = components.firstIndex(of: bundleName) {
            components = Array(components.dropFirst(index + 1))
        }
        if components.count > 1 {
            let lastPathComponent = components.last!
            let directoryPath = components.dropLast().joined(separator: "/")
            if let file = bundle.path(forResource: lastPathComponent, ofType: nil, inDirectory: directoryPath) {
                return file
            }
        }
        if let file = bundle.path(forResource: fileName, ofType: nil) {
            return file
        }
        return nil
        
    }
    
    public static func pathFromFileName(from fileName: String) -> String? {
        let bunlde = self.assetBundle
        let urlPath = bunlde.path(forResource: fileName, ofType: nil)
        return urlPath
    }
    
    public static func resourceFileURL(for fileName: String) -> URL? {
        guard let path = resourcePath(for: fileName)
        else { return nil }
        
        return URL(fileURLWithPath: path)
    }
    
    public static func saveImage(imageName: String, image: UIImage) -> URL? {
        let fileName = imageName
        let fileURL = BaseFileManager.rootFolder.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return nil }

        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("error saving file with error", error.localizedDescription)
            return nil
        }
        return fileURL
    }
    
    public static func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let imageUrl = BaseFileManager.rootFolder.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageUrl.path)
        return image
    }
    
    public static func requestFilter(from url: URL) -> Single<String> {
        let fileName = url.absoluteString
        let fileURL = filterFile(for: fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return .just(fileURL.path)
        }
        let fileData = Single<String>.workItem { single in
            do {
                let data = try Data(contentsOf: url)
                try saveFilterImage(
                    to: fileURL,
                    imageData: data)
              
                single(.success(fileURL.path))
            } catch {
                single(.failure(error))
            }
        }
        
        return fileData
        
    }
    
    public static func localFilter(from url: String) -> String? {
        guard  let range = url.range(of: "framework/"),
               let fileUrl = BaseFileManager.resourceFileURL(
                for: String(url[range.upperBound...])
               )?.path else {
            return nil
        }
        
        return fileUrl
    }
    
    public static func saveFilterImage(to file: URL, imageData: Data) throws {
        let fileManager = FileManager.default
        let folderURL = file.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderURL.path) {
            try? fileManager.createDirectory(
                at: folderURL,
                withIntermediateDirectories: true)
        }
        
        try imageData.write(to: file, options: .atomic)
    }
    
    static public func filterFile(for url: String) -> URL {
        var url = url.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        return rootFolder.appendingPathComponent(url)
    }
}

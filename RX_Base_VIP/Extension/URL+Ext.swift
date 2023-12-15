//
//  URL+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RxSwift

extension URL {
    public func addingQueryItems(_ items: [URLQueryItem]) -> URL {
        guard var urlComponent = URLComponents(url: self, resolvingAgainstBaseURL: true)
        else { return self }
        var urlItems = urlComponent.queryItems ?? []
        urlItems.append(contentsOf: items)
        urlComponent.queryItems = urlItems
        
        return urlComponent.url ?? self
    }
}

extension URL {
    public var fileSize: UInt64 {
        let attributes = try? FileManager.default.attributesOfItem(atPath: self.path) as NSDictionary
        let size = attributes?.fileSize() ?? 0
        debugPrint("File size: \(size)")
        return size
    }
}

extension URL: ReactiveCompatible {
    
}

public extension Reactive where Base == URL {
    var change: Observable<Void> {
        let manager = FileManager.default
        let file = base
        if !manager.fileExists(atPath: file.path) {
            
            let folder = file.deletingLastPathComponent()
            try? manager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
            manager.createFile(atPath: file.path, contents: Data(), attributes: nil)
        }
        
        return Observable<Void>.create { observer in
            let descriptor = open(file.path, O_EVTONLY)
            let folderObserver = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor, eventMask: .all, queue: .none)
            folderObserver.setEventHandler {
                observer.onNext(())
            }
            folderObserver.activate()
            
            observer.onNext(())
            
            return Disposables.create {
                folderObserver.cancel()
            }
        }
    }
}

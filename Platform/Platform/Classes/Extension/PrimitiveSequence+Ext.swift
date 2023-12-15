//
//  PrimitiveSequence+Ext.swift
//  Platform
//
//  Created by Quang Tran on 26/05/2023.
//

import Foundation
import RxSwift
import RxCocoa

extension PrimitiveSequence where Trait == SingleTrait {
    public static func workItem(queue: DispatchQueue = .global(), work: @escaping (SingleObserver) -> Void) -> Single<Element> {
        return .create { single in
            let workItem = DispatchWorkItem {
                work(single)
            }
            
            queue.async(execute: workItem)
            
            return Disposables.create {
                workItem.cancel()
            }
        }
    }
}


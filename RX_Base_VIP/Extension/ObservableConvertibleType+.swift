//
// ObservableConvertibleType+.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

extension ObservableConvertibleType {
    public func asSignalOnErrorJustSkip() -> Signal<Element> {
        return self.asSignal(onErrorSignalWith: .empty())
    }
    
    public func asDriver() -> Driver<Element> {
        return self.asDriver(onErrorDriveWith: .empty())
    }
    
    public func asSignal() -> Signal<Element> {
        return asSignalOnErrorJustSkip()
    }
}

extension BehaviorRelay {
    var mutableValue: Element {
        get {
            return value
        }
        set {
            accept(newValue)
        }
    }
}

extension NSObject: HasDisposeBag {
    
}

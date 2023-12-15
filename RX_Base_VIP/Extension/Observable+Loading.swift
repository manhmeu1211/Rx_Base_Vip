//
//  Observable+Loading.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RxSwift

public extension Observable<Bool> {
    static func combineLoading(from collection: [Observable<Bool>]) -> Observable<Bool> {
        let newCollection = collection
            .map { $0.startWith(false) }
        
        return Self.combineLatest(newCollection)
            .map { return $0.firstIndex(of: true) != nil }
        
    }
}

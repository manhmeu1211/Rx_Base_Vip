//
//  Reorder.swift
//  Platform
//
//  Created by Mạnh Lương on 02/08/2023.
//

import Foundation

public protocol Reorderable {
    associatedtype OrderElement: Equatable
    var orderElement: OrderElement { get }
}

public extension Array where Element: Reorderable {

    func reorder(by preferredOrder: [Element.OrderElement]) -> [Element] {
        sorted {
            guard let first = preferredOrder.firstIndex(of: $0.orderElement) else {
                return false
            }

            guard let second = preferredOrder.firstIndex(of: $1.orderElement) else {
                return true
            }

            return first < second
        }
    }
}

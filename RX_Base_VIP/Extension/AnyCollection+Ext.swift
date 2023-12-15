//
//  AnyCollection+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation

public extension AnyCollection {
    func element(at index: Int) -> Element? {
        return dropFirst(index).first
    }
}

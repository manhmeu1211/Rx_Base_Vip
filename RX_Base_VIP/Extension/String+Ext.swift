//
//  String+Ext.swift
//  EditorBase
//
//  Created by Trung Vu on 18/07/2023.
//

import Foundation

public extension String {
    static func parse(from string: String) -> Int {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
    }
}

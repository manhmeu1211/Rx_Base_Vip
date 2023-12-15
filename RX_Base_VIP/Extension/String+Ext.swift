//
//  String+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: AppDelegate.self), comment: "")
    }
}

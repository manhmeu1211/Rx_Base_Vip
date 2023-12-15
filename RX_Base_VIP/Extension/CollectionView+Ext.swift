//
//  CollectionView+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    static func scrollDirection(_ direction: UICollectionView.ScrollDirection)
    -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        return .init(frame: .zero, collectionViewLayout: layout)
    }
}

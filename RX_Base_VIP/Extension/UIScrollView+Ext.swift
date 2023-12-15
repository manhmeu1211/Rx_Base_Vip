//
//  UIScrollView+Ext.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit

extension UIScrollView {
    func scrollToCenterHorizontal(of view: UIView, animated: Bool) {
        let viewBounds = view.bounds
        let viewFrameInScollView = self.convert(viewBounds, from: view)
        let viewCenter = viewFrameInScollView.midX
        var contentOffset = viewCenter - self.bounds.width / 2
        let minContentOffset = -contentInset.left
        let maxContentOffset = contentSize.width - bounds.width + contentInset.right
        contentOffset = min(maxContentOffset, contentOffset)
        contentOffset = max(minContentOffset, contentOffset)
        let currentContentOffset = self.contentOffset
        setContentOffset(.init(x: contentOffset, y: currentContentOffset.y),
                         animated: animated)
    }
    
    func scrollToTop(of view: UIView, animated: Bool) {
        let viewBounds = view.bounds
        let viewFrameInScollView = self.convert(viewBounds, from: view)
        let viewTop = viewFrameInScollView.minY
        var contentOffset = viewTop
        let minContentOffset = -safeAreaInsets.top
        let maxContentOffset = contentSize.height - bounds.height + contentInset.bottom
        contentOffset = min(maxContentOffset, contentOffset)
        contentOffset = max(minContentOffset, contentOffset)
        let currentContentOffset = self.contentOffset
        setContentOffset(.init(x: currentContentOffset.x, y: contentOffset),
                         animated: animated)
    }
}

//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import UIKit
import RxCocoa
import RxSwift

public extension Reactive where Base: UICollectionView {
    var didScrollToIndexPath: ControlEvent<IndexPath> {
        let source = didScroll
            .filter { [weak base] in
                guard let base = base else { return false }
                return base.isDragging ||
                base.isDecelerating
            }
            .compactMap { [weak base] _ -> IndexPath? in
                guard let base = base else { return nil }
                return base.indexPathsForVisibleItems.min()
            }
        
        return .init(events: source)
    }
}

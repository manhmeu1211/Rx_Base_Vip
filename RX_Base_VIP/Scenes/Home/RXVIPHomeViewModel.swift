// 
//  RXVIPHomeViewModel.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import RXVIPArchitechture

class RXVIPHomeViewModel: HasDisposeBag {
    let navigator: RXVIPHomeNavigatorType

    init(navigator: RXVIPHomeNavigatorType) {
        self.navigator = navigator
    }
}

extension RXVIPHomeViewModel: ViewModelType {
    func transform(input: Input) -> Output {

        return .init()
    }
}

extension RXVIPHomeViewModel {
    struct Input {
        
    }
    
    struct Output {
    }
}

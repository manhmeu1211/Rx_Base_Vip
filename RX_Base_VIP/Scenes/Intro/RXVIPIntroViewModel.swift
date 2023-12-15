//
//  IntroViewModel.swift
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RXVIPArchitechture

class RXVIPIntroViewModel {
    private let navigator: RXVIPIntroNavigatorType
    private let disposeBag = DisposeBag()
    
    init(navigator: RXVIPIntroNavigatorType) {
        self.navigator = navigator
    }
}

extension RXVIPIntroViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let totalPage = 4
        
        let pushable = input.nextButtonTrigger
            .withLatestFrom(input.didScrollToPageIndex)
            .filter({ $0 >= totalPage - 1 })
            .mapToVoid()
            .compactMap({ [weak self] _ -> NavigatorType? in
                return self?.navigator.homeNavigator()
            })
                
        return .init(
            nextPageTrigger: input.nextButtonTrigger,
            pushable: pushable)
    }
}

extension RXVIPIntroViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let nextButtonTrigger: Driver<Void>
        let didScrollToPageIndex: Driver<Int>
    }
    
    struct Output {
        let nextPageTrigger: Driver<Void>
        let pushable: Driver<NavigatorType>
    }
}

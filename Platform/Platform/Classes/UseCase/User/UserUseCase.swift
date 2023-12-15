//
//  UserUseCase.swift
//  Platform
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import Domain
import RxCocoa
import RxSwift
import Platform

class UserUseCase: Domain.UserUseCase {
    
    func localUserInfo() -> Domain.UserEntity {
        return UserEntity.currentUser
    }
}

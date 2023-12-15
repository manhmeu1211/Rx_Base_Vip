//
//  UseCaseProvider.swift
//  Platform
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import Domain

public class UseCaseProvider {
    static public func makeUserUseCase() -> Domain.UserUseCase {
        return UserUseCase()
    }
}

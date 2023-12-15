//
//  PPUserUseCase.swift
//  Alamofire
//
//  Created by Mạnh Lương on 22/06/2023.
//

import Foundation
import RxSwift
import RxCocoa

public protocol UserUseCase {
    func localUserInfo() -> UserEntity
}

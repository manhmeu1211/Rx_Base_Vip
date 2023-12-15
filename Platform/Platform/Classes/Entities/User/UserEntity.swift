//
//  PPUserEntity.swift
//  Platform
//
//  Created by Dang Hung on 6/20/23.
//

import Foundation
import RealmSwift
import Domain
import Platform

class UserEntity: Object, Domain.UserEntity {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String?
    
    convenience init(name: String?) {
        self.init()
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension UserEntity {
    static var currentUser: UserEntity {
        var user: UserEntity
        
        if let firstuser = RealmManager.objects(ofType: UserEntity.self).first {
            user = firstuser
        } else {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            let newUser = UserEntity(name: deviceId)
            RealmManager.add(object: newUser)
            user = newUser
        }
        
        return user
    }

}

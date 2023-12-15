//
//  RealmManager.swift
//  Platform
//
//  Created by Luong Manh on 15/12/2023.
//

import Foundation
import RealmSwift
import Domain

public final class RealmManager {
    
    public static var realm: Realm { try! Realm() }
    
    public static func getRealm() -> Realm {
        let realm = try! Realm()
        return realm
    }
    
    public static func objects<T: Object>(ofType objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    public static func object<T: Object>(ofType objectType: T.Type, key: Any) -> T? {
        return realm.object(ofType: objectType, forPrimaryKey: key)
    }
    
    public static func add<T: Object>(object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    public static func update<T: Object>(object: T) {
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
    
    public static func delete<T: Object>(object: T) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    public static func clearAllData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    public static func transaction(block: @escaping ((Realm) -> Void)) throws {
        let realm = try Realm()
        
        try realm.write {
            block(realm)
        }
    }
}

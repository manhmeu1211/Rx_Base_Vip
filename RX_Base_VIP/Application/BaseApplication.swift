//
//  BaseABaselication.swift
//  RX_Base_VIP
//
//  Created by Luong Manh on 15/12/2023.
//
import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class BaseApplication {
    static let shared = BaseApplication()
    let disposeBag = DisposeBag()
    
    private init () {
//        UIView.configBaseApperance()
        configFirebase()
        configRealmDatabase()
    }
    
    func configMainInterface(in window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        let navigator = BaseApplicationNavigator()
        let viewController = UINavigationController(
            rootViewController: navigator.makeViewController())
        window.rootViewController = viewController
        
//        #endif
    }
}

extension BaseApplication {
    func configFirebase() {
    }
}

extension BaseApplication {
    func configRealmDatabase() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            schemaVersion: 1,
            // Set the block which will be called automatically when opening a Realm
            migrationBlock: { _, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion < 1 {
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
}

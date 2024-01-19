//
//  Realm+extension.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/15/24.
//

import RealmSwift

extension Realm {
    static var userConfiguration: Realm.Configuration {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = 1
        configuration.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.renameProperty(onType: User.className(), from: "bio", to: "biography")
            }
        }
        return configuration
    }
    
    static var repositoryConfiguration: Realm.Configuration {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = 1
        return configuration
    }
    
    static func open(configuration: Realm.Configuration) -> Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            print("램 오픈 실패")
        }
        return try! Realm(configuration: configuration)
    }
}

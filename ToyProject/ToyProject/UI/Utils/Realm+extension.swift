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
        configuration.schemaVersion = 0
        return configuration
    }
    
    static var repositoryConfiguration: Realm.Configuration {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = 0
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

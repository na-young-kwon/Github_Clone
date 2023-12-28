//
//  Realm+extension.swift
//  ToyProject
//
//  Created by SNPLAB on 12/28/23.
//

import Foundation
import RealmSwift

extension Realm {
    static var searchHistoryConfiguration: Configuration {
        var configuration = Realm.Configuration(schemaVersion: 2) { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: SearchHistoryForRealm.className()) { oldObject, newObject in
                        newObject?["createdAt"] = nil
                    }
                }
            }
        
        return configuration
    }
    
    static public func open(configuration : Realm.Configuration) -> Realm {
        do {
            return try Realm(configuration : configuration)
        } catch {
            print("RealmExtension, error ocurred during opening a realm file, \(error)")
            return try! Realm(configuration : configuration)
        }
    }
}

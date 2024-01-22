//
//  Migration.swift
//  ToyProject
//
//  Created by woosub kim  on 1/22/24.
//

import Foundation
import RealmSwift

class Migrator {
    
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 1) { migration,oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.renameProperty(onType: UserForRealm.className(), from: "bio", to: "biography")
                
                migration.enumerateObjects(ofType: UserForRealm.className()) { oldObject, newObject in
                    
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
    }
}

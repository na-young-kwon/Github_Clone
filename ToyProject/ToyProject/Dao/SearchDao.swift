//
//  SearchDao.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/3/24.
//

import Foundation
import RealmSwift

struct SearchDao {
    var realm: Realm {
        do {
            return try Realm(configuration: Realm.searchConfiguration)
        } catch {
            // 파일 열때 에러 발생
            print("error occured during oprning a realm file, \(error)")
            
            // 저 프로젝트 에서는
            // 열기 실패 -> 파일 삭제 로 구현
            
            return try! Realm(configuration : Realm.searchConfiguration)
        }
    }
}

extension Realm {
    static var searchConfiguration: Configuration {
        var configuration = Realm.baseConfiguration
        // 각 DAO 마다 pathComponent 추가
        configuration.fileURL = configuration.fileURL?.appendingPathComponent("SearchHistory.realm")
        
        configuration.schemaVersion = Realm.schemaVersion
        // 왜 하는지..?
        configuration.objectTypes = [SearchHistoryForRealm.self]
        configuration.migrationBlock = { migration, oldVersion in
            migration.renameProperty(onType: SearchHistoryForRealm.className(), from: "text", to: "userName")
            migration.enumerateObjects(ofType: SearchHistoryForRealm.className()) { oldHistory, newHistory in
                
            }
        }
        
        return configuration
    }
}

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
            // 이게 램 파일 여는것
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

extension SearchDao {
    func loadHistory() -> Results<SearchHistoryForRealm> {
        return realm.objects(SearchHistoryForRealm.self)
    }
    
    // 이 부분 어색 user - SearchHistory 네이밍 수정 필요
    func saveHistory(_ user: SearchHistory) {
        guard realm.objects(SearchHistoryForRealm.self).filter ({ $0.id == user.id }).isEmpty else {
            return
        }
        do {
            try realm.write {
                let search = SearchHistoryForRealm(id: user.id, userName: user.text)
                realm.add(search)
            }
        } catch {
            print("Failed to save user for realm error: \(error)")
        }
    }
    
    func delete(_ historyId: Int) {
        do {
            let task = realm.objects(SearchHistoryForRealm.self).where { $0.id == historyId }
            try realm.write {
                realm.delete(task)
            }
        } catch let error {
            print("Failed to delete history for realm error: \(error)")
        }
    }
}

extension Realm {
    static var searchConfiguration: Configuration {
        var configuration = Realm.baseConfiguration
        // 각 DAO 마다 pathComponent 추가
        configuration.fileURL = configuration.fileURL?.appendingPathComponent("SearchHistory.realm")
        
        configuration.schemaVersion = Realm.schemaVersion
        configuration.migrationBlock = { migration, oldVersion in
            
            // 컬럼명 변경
            migration.renameProperty(onType: SearchHistoryForRealm.className(), from: "text", to: "userName")
            
            // 이거 안해도 자동 삭제 되는듯?
//            migration.enumerateObjects(ofType: SearchHistoryForRealm.className()) { oldHistory, newHistory in
//                oldHistory?["id"] = nil
//            }
        }
        // 타입 제한
        // 다른 타입 저장하려고 할 때 어떻게 되는지 궁금. 에러 발생시키는건가
        configuration.objectTypes = [SearchHistoryForRealm.self]
        return configuration
    }
}

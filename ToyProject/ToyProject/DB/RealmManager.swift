//
//  RealmManager.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/28/23.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private let realm: Realm = {
        let supportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        if !FileManager.default.fileExists(atPath: supportURL.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: supportURL, withIntermediateDirectories: true, attributes: nil)
                print("디렉토리 만들기 성공")
            } catch {
                print("디렉토리 만들기 실패: \(error)")
            }
        }
        
        var configuration = Realm.Configuration(fileURL: supportURL) // configuration 정의
        configuration.fileURL = configuration.fileURL?.appendingPathComponent("SearchHistory.realm") // 확장자까지 작성해줘야 함
        configuration.schemaVersion = 9
        
        configuration.migrationBlock = { migration, oldVersion in
            if oldVersion < 1 {
                // add - nothing to do
            }
            if oldVersion < 2 {
                // delete - nothing to do
            }
            if oldVersion < 3 {
                migration.renameProperty(onType: SearchHistoryForRealm.className(), from: "id", to: "userID")
            }
            if oldVersion < 4 {
                migration.enumerateObjects(ofType: SearchHistoryForRealm.className()) { oldObject, newObject in
                    // 이 부분 스키마 올려서 다시 실험하기
                    guard let old = oldObject else { return }
                    guard let new = newObject else { return }
                    
                    let uuid = old["userID"] as! UUID
                    new["userID"] = uuid.hashValue
                }
            }
        }
        
        do {
            return try Realm(configuration: configuration) // realm 열기
        } catch {
            print("램 파일 open 과정에서 에러 발생: \(error)") // 에러발생해서 realm 안열림
            do {
                let result = try Realm.deleteFiles(for: configuration) // configuration에 해당하는 파일 삭제
                if result == true {
                    print("삭제 결과: \(result)")
                }
            } catch {
                print("삭제 에러 발생: \(error)")
            }
        }
        return try! Realm(configuration: configuration)
    }()
    
    private init() {}
    
    func create(_ searchHistory: SearchHistory) {
        guard searchHistory.text.trimmingCharacters(in: .whitespaces) != ""
                && realm.objects(SearchHistoryForRealm.self).filter({ $0.userName == searchHistory.text }).isEmpty else {
            return
        }
        do {
            try realm.write {
                let search = SearchHistoryForRealm(id: searchHistory.id, userName: searchHistory.text)
                realm.add(search)
            }
        } catch {
            print("Failed to create error: \(error)")
        }
    }
    
    func read() -> [SearchHistory] {
        // 현재 스키마 버전 확인
        let version = try? schemaVersionAtURL(realm.configuration.fileURL!)
        print("스키마 버전: \(version)")
        
        var searchHistory = [SearchHistory]()
        let searchHistoryForRealm = realm.objects(SearchHistoryForRealm.self)
        
        for history in searchHistoryForRealm {
            searchHistory.append(SearchHistory(id: history.userID, text: history.userName))
        }
        return searchHistory
    }
    
    func delete(_ searchHistory: SearchHistory) {
        do {
            let task = realm.objects(SearchHistoryForRealm.self).where { $0.userID == searchHistory.id }
            try realm.write {
                realm.delete(task)
            }
        } catch let error {
            print("list를 삭제하는 데 실패했습니다 - \(error)")
        }
    }
}

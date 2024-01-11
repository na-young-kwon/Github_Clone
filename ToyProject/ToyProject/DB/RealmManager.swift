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
//    private let realm = try! Realm()
    
    private init() {}
    
    func create(_ searchHistory: SearchHistory) {
        let realm = try! Realm()
        guard !searchHistory.text.trimmingCharacters(in: .whitespaces).isEmpty
                && realm.objects(SearchHistoryForRealm.self).filter({ $0.text == searchHistory.text }).isEmpty else {
            return
        }
        
        do {
            try realm.write {
                let search = SearchHistoryForRealm(id: searchHistory.id, text: searchHistory.text)
                realm.add(search)
            }
        } catch {
            print("Failed to create error: \(error)")
        }
    }
    
    func read() -> [SearchHistory] {
        var searchHistory = [SearchHistory]()
        let realm = try! Realm()
        let searchHistoryForRealm = realm.objects(SearchHistoryForRealm.self)
        
        for history in searchHistoryForRealm {
            searchHistory.append(SearchHistory(id: history.id, text: history.text))
        }
        return searchHistory
    }
    
    func delete(_ searchHistory: SearchHistory) {
        let realm = try! Realm()
        do {
            let task = realm.objects(SearchHistoryForRealm.self).where { $0.id == searchHistory.id }
            try realm.write {
                realm.delete(task)
            }
        } catch let error {
            print("list를 삭제하는 데 실패했습니다 - \(error)")
        }
    }
}

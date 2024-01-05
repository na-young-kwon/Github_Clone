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
    private let realm = try! Realm()
    
    private init() {}
    
    func create(_ searchHistory: SearchHistory) {
        guard searchHistory.text.trimmingCharacters(in: .whitespaces) != ""
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
        let historyForRealm = realm.objects(SearchHistoryForRealm.self)
        let searchHistory = historyForRealm.map { SearchHistory(id: $0.id, text: $0.text) }
        
        return Array(searchHistory)
    }
    
    func delete(_ searchHistory: SearchHistory) {
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

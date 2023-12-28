//
//  RealmManager.swift
//  ToyProject
//
//  Created by SNPLAB on 12/28/23.
//

import Foundation
import RealmSwift

struct RealmManager {
    static var shared = RealmManager()
    let realm = try! Realm()
    
    private init() { }
    
    func create(_ searchHistory: SearchHistory) {
        do {
            try realm.write {
                let search = SearchHistoryForRealm(text: searchHistory.text)
                realm.add(search)
            }
        } catch {
            print("Failed to create error: \(error)")
        }
    }
    
    func read() -> [SearchHistory] {
        var searchHistory = [SearchHistory]()
        let searchHistoryForRealm = realm.objects(SearchHistoryForRealm.self)
        
        searchHistoryForRealm.forEach { history in
            searchHistory.append(SearchHistory(text: history.text))
        }
        return searchHistory
    }
}

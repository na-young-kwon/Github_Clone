//
//  SearchRepository.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation
import RealmSwift

protocol SearchDelegate {
    func saveSearchText(_ searchHistory: SearchHistory)
    func fetchSearchHistory() -> [SearchHistory]
}

struct SearchRepository: SearchDelegate {

    func saveSearchText(_ searchHistory: SearchHistory) {
        RealmManager.shared.create(searchHistory)
    }
    
    func fetchSearchHistory() -> [SearchHistory] {
        RealmManager.shared.read()
    }
}

class SearchHistoryForRealm: Object {
    @objc dynamic var text: String
    @objc dynamic var searchDate: Date
    
    init(text: String, searchDate: Date = Date()) {
        self.text = text
        self.searchDate = searchDate
    }
}

struct RealmManager {
    static var shared = RealmManager()
    let realm = try! Realm()
    
    private init() { }
    
    func create(_ searchHistory: [SearchHistory]) {
        try! realm.write {
            let search = SearchHistoryForRealm(text: searchHistory.text)
            
            realm.add(search)
        }
    }

    func read() -> [SearchHistory] {
        var searchHistory = [SearchHistory]()
        
        let searchHistoryForRealm = realm.objects(SearchHistoryForRealm.self)
        searchHistoryForRealm.forEach { history in
            // here
//            searchHistory.append(history)
        }
        
        return searchHistory
    }
}

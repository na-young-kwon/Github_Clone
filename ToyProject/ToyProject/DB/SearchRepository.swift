//
//  SearchRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

protocol SearchDelegate {
    func saveSearchText(_ searchHistory: SearchHistory)
    func fetchSearchHistory() -> [SearchHistory]
    func deleteSearchText(_ searchHistory: SearchHistory)
}

struct SearchRepository: SearchDelegate {

    func saveSearchText(_ searchHistory: SearchHistory) {
        RealmManager.shared.create(searchHistory)
    }
    
    func fetchSearchHistory() -> [SearchHistory] {
        RealmManager.shared.read()
    }
    
    func deleteSearchText(_ searchHistory: SearchHistory) {
        RealmManager.shared.delete(searchHistory)
    }
}

//
//  SearchRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

protocol SearchDelegate {
    func fetchSearchHistory() -> [SearchHistory]
    func deleteSearchText(_ searchHistory: SearchHistory)
}

struct SearchRepository: SearchDelegate {
    func fetchSearchHistory() -> [SearchHistory] {
        RealmManager.shared.read()
    }
    
    func deleteSearchText(_ searchHistory: SearchHistory) {
        RealmManager.shared.delete(searchHistory)
    }
}

//
//  SearchRepository.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation

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

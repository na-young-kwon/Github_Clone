//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation

struct SearchUsecase {
    let repository: SearchRepository = SearchRepository()
    
    func saveSearchText(_ searchHistory: SearchHistory) {
        repository.saveSearchText(searchHistory)
    }
    
    func fetchSearchHistory() -> [SearchHistory] {
        return repository.fetchSearchHistory()
    }
}
//
//  SearchRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

protocol SearchDelegate {
    func saveSearchHistory(_ searchHistory: SearchHistory)
    func getSearchHistory() -> [SearchHistory]
    func deleteHistory(_ historyId: Int)
}

struct SearchRepository: SearchDelegate {
    private let dao = SearchDao()
    
    func saveSearchHistory(_ searchHistory: SearchHistory) {
        dao.saveHistory(searchHistory)
    }
    
    func getSearchHistory() -> [SearchHistory] {
        var searchHistory = [SearchHistory]()
        let histories = dao.loadHistory()
        
        for history in histories {
            searchHistory.append(SearchHistory(id: history.id, text: history.userName))
        }
        return searchHistory
    }
    
    func deleteHistory(_ historyId: Int) {
        dao.delete(historyId)
    }
}

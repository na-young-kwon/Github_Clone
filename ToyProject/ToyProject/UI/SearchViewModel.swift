//
//  SearchViewModel.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchHistory: [SearchHistory] = []
    
    private let usecase: SearchUsecase = SearchUsecase()
    
    func saveSearch(_ searchHistory: SearchHistory) {
        usecase.saveSearchText(searchHistory)
    }
    
    func fetchSearchHistory() {
        searchHistory = usecase.fetchSearchHistory()
    }
    
    func deleteSearch(_ searchHistory: SearchHistory) {
        usecase.deleteSearchText(searchHistory)
    }
    
    func deleteItem(at indexSet: IndexSet) {
        for index in indexSet {
            let searchHistoryItem = searchHistory[index]
            deleteSearch(searchHistoryItem)
        }
        searchHistory.remove(atOffsets: indexSet)
    }
    
}

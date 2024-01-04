//
//  SearchViewModel.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchHistory: [SearchHistory] = []
    
    private let usecase: SearchUsecase = SearchUsecase()
    
    func fetchSearchHistory() {
        searchHistory = usecase.fetchSearchHistory()
    }
    
    func deleteItem(at indexSet: IndexSet) {
        for index in indexSet {
            let searchHistoryItem = searchHistory[index]
            usecase.deleteSearchText(searchHistoryItem.id)
            searchHistory = usecase.fetchSearchHistory()
        }
    }
}

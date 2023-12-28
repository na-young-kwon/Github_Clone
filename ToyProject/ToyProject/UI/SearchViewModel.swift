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
        print("\(#fileID) \(#line)-line \(#function)")
        usecase.deleteSearchText(searchHistory)
    }
    
}

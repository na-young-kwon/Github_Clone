//
//  SearchViewModel.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchHistory: [UserVo] = []
    
    private let usecase = SearchUsecase()
    
    func fetchSearchHistory() {
        searchHistory = usecase.getAllUsers()
    }
    
    func deleteItem(at indexSet: IndexSet) {
        for index in indexSet {
            let user = searchHistory[index]
            usecase.deleteUser(user)
        }
        searchHistory = usecase.getAllUsers()
    }
}

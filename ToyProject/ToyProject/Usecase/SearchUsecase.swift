//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchUsecase {
    private let repository: SearchRepository = SearchRepository()

    func fetchSearchHistory() -> [UserResponse] {
        return repository.fetchSearchHistory()
    }
    
    func deleteSearchText(_ user: UserResponse) {
        repository.deleteSearchText(user)
    }
}

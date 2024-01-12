//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchUsecase {
    private let repository: SearchRepository = SearchRepository()

    func fetchSearchHistory() -> [UserVo] {
        return repository.fetchSearchHistory()
    }
    
    func deleteSearchText(_ user: UserVo) {
        repository.deleteSearchText(user)
    }
}

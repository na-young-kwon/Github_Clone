//
//  SearchRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

protocol SearchDelegate {
    func fetchSearchHistory() -> [UserResponse]
    func deleteSearchText(_ user: UserResponse)
}

struct SearchRepository: SearchDelegate {
    func fetchSearchHistory() -> [UserResponse] {
        UserRealmManager.shared.getAllUsers()
    }
    
    func deleteSearchText(_ user: UserResponse) {
        UserRealmManager.shared.delete(user)
    }
}

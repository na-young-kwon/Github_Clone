//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation
import Alamofire

struct RepositoryUseCase {
    let networkService = NetworkService()
    
    func saveSearchText(_ searchHistory: SearchHistory) {
        RealmManager.shared.create(searchHistory)
    }
    
    func getRepositories(forUser username: String) async throws -> [UserResponse] {
        return try await networkService.fetchRepositories(forUser: username)
    }
    
    func getUser(foruser username: String) async throws -> UserResponse {
        return try await networkService.fetchUser(forUser: username)
    }
}

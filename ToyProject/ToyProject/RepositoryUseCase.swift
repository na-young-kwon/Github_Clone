//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation
import Alamofire

struct RepositoryUseCase {
    private let networkService = NetworkService()
    private let repository = SearchRepository()
    
    func getRepositories(forUser username: String) async throws -> [UserResponse] {
        return try await networkService.fetchRepositories(forUser: username)
    }
    
    func getUser(forUser username: String) async throws -> UserResponse {
        return try await networkService.fetchUser(forUser: username)
    }
    
    func saveSearchHistory(_ searchHistory: SearchHistory) {
        repository.saveSearchHistory(searchHistory)
    }
}

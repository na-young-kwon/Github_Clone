//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation
import Alamofire

struct NetworkUseCase {
    let networkService = NetworkService()
    
    func getRepositories(forUser username: String) async throws -> [RepositoryResponse] {
        return try await networkService.fetchRepositories(forUser: username)
    }
    
    func getUser(forUser username: String) async throws -> UserResponse {
        return try await networkService.fetchUser(forUser: username)
    }
}

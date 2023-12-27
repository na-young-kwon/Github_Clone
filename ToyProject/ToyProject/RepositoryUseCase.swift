//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation
import Alamofire

struct RepositoryUseCase {
    private var networkService = NetworkService()
    
    func getRepository(forUser username: String, repositoryName: String) async throws -> UserResponse {
        return try await networkService.fetchRepository(username: username, repositoryName: repositoryName)
    }
    
    func getRepositories(forUser username: String) async throws -> [UserResponse] {
        return try await networkService.fetchRepositories(forUser: username)
    }
}

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
    
    /// 단일 레포지토리를 요청
    func getRepository(forUser username: String, repositoryName: String) async throws -> UserResponse {
        return try await networkService.fetchRepository(username: username, repositoryName: repositoryName)
    }
    
    ///
    func getRepositories(forUser username: String) async throws -> [UserResponse] {
        return try await networkService.fetchRepositories(forUser: username)
    }
    
    func getUser(foruser username: String) async throws -> UserResponse {
        return try await networkService.fetchUser(forUser: username)
    }
}

//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation
import Alamofire

/// created by 김우섭
struct NetworkUseCase {
    let networkService = NetworkService()
    
    func getUser(forUser username: String) async throws -> UserDTO {
        return try await networkService.fetchUser(forUser: username)
    }
    
    func getRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        return try await networkService.fetchRepositories(forUser: username)
    }
}

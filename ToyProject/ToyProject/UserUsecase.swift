//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation
import Alamofire

struct UserUsecase {
    let networkService = NetworkService()
    
    func getRepositories(forUser username: String) async throws -> [RepositoryResponse] {
        if let repo = RepositoryRealmManager.shared.getRepository(by: username) {
            return repo
        }
        let repository = try await networkService.fetchRepositories(forUser: username)
        RepositoryRealmManager.shared.create(repository)
        return repository
    }
    
    func getUser(forUser username: String) async throws -> UserResponse {
        if let userFromRealm = UserRealmManager.shared.getUser(by: username) {
            return userFromRealm
        }
        let userFromServer = try await networkService.fetchUser(forUser: username)
        UserRealmManager.shared.create(userFromServer)
        return userFromServer
    }
}

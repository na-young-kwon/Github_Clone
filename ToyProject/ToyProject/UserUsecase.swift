//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

// 작성자: nayoung kwon

import Foundation
import Alamofire

struct UserUsecase {
    let networkService = NetworkService()
    let repository = UserRepository()
    
//    @MainActor // 여기 왜 main thread에서 안도는지 궁금..
    func getUser(forUser username: String) async throws -> UserVo {
        if let user = repository.getUser(by: username) {
            return user
        }
        return try await repository.fetchUser(by: username)
    }
    
//    @MainActor
    func getRepositoryList(forUser username: String) async throws -> [RepositoryVo] {
        if let repositoryList = repository.getRepositoryList(forUser: username) {
            return repositoryList
        }
        return try await repository.fetchRepositories(forUser: username)
    }
}

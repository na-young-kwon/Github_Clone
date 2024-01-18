//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

// 작성자: nayoung kwon

import Foundation

struct UserUsecase {
    let userRepository: UserRepository = UserRepository()
    let repoRepository: RepoRepository = RepoRepository()
    
    func getUser(forUser username: String) -> UserVo? {
        return userRepository.getUser(by: username)
    }
    
    func fetchUser(forUser username: String) async throws -> UserVo {
        return try await userRepository.fetchUser(by: username)
    }
    
    func getRepositoryList(forUser username: String) -> [RepositoryVo] {
        return repoRepository.getRepositoryList(forUser: username)
    }
    
    func fetchRepositoryList(forUser username: String) async throws -> [RepositoryVo] {
        return try await repoRepository.fetchRepositoryList(forUser: username)
    }
}

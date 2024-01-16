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
    
    func getUser(forUser username: String) async throws -> UserVo {
        if let user = userRepository.getUser(by: username) {
            return user
        }
        return try await userRepository.fetchUser(by: username)
    }
    
    func getRepositoryList(forUser username: String) async throws -> [RepositoryVo] {
        let repositoryList = repoRepository.getRepositoryList(forUser: username)
        
        if !repositoryList.isEmpty {
            return repositoryList
        }
        return try await repoRepository.fetchRepositories(forUser: username)
    }
}

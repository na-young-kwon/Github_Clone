//
//  RepositoryUseCase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

/// created by 김우섭
struct RepoUseCase {
    private let repoRepository: RepoRepository = RepoRepository()
    
    func saveRepository(_ repositoryResponse: RepositoryResponse) {
        repoRepository.saveRepository(repositoryResponse)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryResponse] {
        return repoRepository.fetchRepository(userName)
    }
    
    func fetchRepositories() -> [RepositoryResponse] {
        repoRepository.fetchRepositories()
    }

    func deletRepository(_ userName: String) {
        repoRepository.deleteRepository(userName)
    }
}

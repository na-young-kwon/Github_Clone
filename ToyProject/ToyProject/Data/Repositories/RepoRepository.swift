//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
protocol RepoDelegate {
    func saveRepository(_ repositoryResponse: RepositoryResponse)
    func fetchRepository(_ userName: String) -> [RepositoryResponse]
    func fetchRepositories() -> [RepositoryResponse]
    func deleteRepository(_ userName: String)
}

struct RepoRepository: RepoDelegate {
    
    func saveRepository(_ repositoryResponse: RepositoryResponse) {
        RepositoryRealmManager.shared.create(repositoryResponse)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryResponse] {
        RepositoryRealmManager.shared.read(userName)
    }
    
    func fetchRepositories() -> [RepositoryResponse] {
        RepositoryRealmManager.shared.readAll()
    }
    
    func deleteRepository(_ userName: String) {
        RepositoryRealmManager.shared.delete(userName)
    }
}

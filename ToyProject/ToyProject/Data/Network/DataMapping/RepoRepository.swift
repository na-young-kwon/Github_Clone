//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
protocol RepoDelegate {
    func saveRepository(_ repositoryDTO: RepositoryDTO)
    func fetchRepository(_ userName: String) -> [RepositoryDTO]
    func fetchRepositories() -> [RepositoryDTO]
    func deleteRepository(_ userName: String)
}

struct RepoRepository: RepoDelegate {
    
    func saveRepository(_ repositoryDTO: RepositoryDTO) {
        RepositoryRealmManager.shared.create(repositoryDTO)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryDTO] {
        RepositoryRealmManager.shared.read(userName)
    }
    
    func fetchRepositories() -> [RepositoryDTO] {
        RepositoryRealmManager.shared.readAll()
    }
    
    func deleteRepository(_ userName: String) {
        RepositoryRealmManager.shared.delete(userName)
    }
}

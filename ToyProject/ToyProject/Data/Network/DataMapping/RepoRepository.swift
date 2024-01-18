//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
protocol RepoDelegate {
    func saveRepository(_ repositoryDTO: [RepositoryDTO])
    func fetchRepository(_ userName: String) -> [RepositoryDTO]
    func fetchRepositories() -> [RepositoryDTO]
    func deleteRepository(_ userName: String)
}

struct RepoRepository: RepoDelegate {
    
    func saveRepository(_ repositoryDTO: [RepositoryDTO]) {
        RepositoryDAO.shared.create(repositoryDTO)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryDTO] {
        RepositoryDAO.shared.read(userName)
    }
    
    func fetchRepositories() -> [RepositoryDTO] {
        RepositoryDAO.shared.readAll()
    }
    
    func deleteRepository(_ userName: String) {
        RepositoryDAO.shared.delete(userName)
    }
}

//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

protocol RepoDelegate {
    func saveRepository(_ repositoryResponse: RepositoryResponse)
    func fetchRepository(_ userName: String) -> [RepositoryResponse]
    func deleteRepository(_ repositoryResponse: RepositoryResponse)
}

struct RepoRepository: RepoDelegate {
    
    func saveRepository(_ repositoryResponse: RepositoryResponse) {
        RepositoryRealmManager.shared.create(repositoryResponse)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryResponse] {
        RepositoryRealmManager.shared.read(userName)
    }
    
    func deleteRepository(_ repositoryResponse: RepositoryResponse) {
        RepositoryRealmManager.shared.delete(repositoryResponse)
    }
}

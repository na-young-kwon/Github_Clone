//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

protocol RepoDelegate {
    func saveUser(_ userResponse: RepositoryResponse)
    func fetchUser() -> [RepositoryResponse]
    func deleteUser(_ userResponse: RepositoryResponse)
}

struct RepoRepository: RepoDelegate {
    func saveUser(_ repoResponse: RepositoryResponse) {
        RepositoryRealmManager.shared.create(repoResponse)
    }
    
    func fetchUser() -> [RepositoryResponse] {
        RepositoryRealmManager.shared.read()
    }
    
    func deleteUser(_ userResponse: RepositoryResponse) {
        RepositoryRealmManager.shared.delete(userResponse)
    }
}

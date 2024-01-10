//
//  RepositoryUseCase.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

struct RepoUseCase {
    private let repoRepository: RepoRepository = RepoRepository()
    
    func saveUser(_ repoResponse: RepositoryResponse) {
        repoRepository.saveUser(repoResponse)
    }
    
    func fetchUser() -> [RepositoryResponse] {
        return repoRepository.fetchUser()
    }
    
    func deleteUser(_ repoResponse: RepositoryResponse) {
        repoRepository.deleteUser(repoResponse)
    }
}

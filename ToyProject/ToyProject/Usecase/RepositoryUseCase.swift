//
//  RepositoryUseCase.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

struct RepoUseCase {
    private let repoRepository: RepoRepository = RepoRepository()
    
    func saveRepository(_ repositoryResponse: RepositoryResponse) {
        repoRepository.saveRepository(repositoryResponse)
    }
    
    func fetchUser(_ userName: String) -> [RepositoryResponse] {
        return repoRepository.fetchRepository(userName)
    }
    
 
}

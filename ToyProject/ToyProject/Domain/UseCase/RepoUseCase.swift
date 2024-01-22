//
//  RepositoryUseCase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

struct RepoUseCase {
    private let repoRepository: RepoRepository = RepoRepository()
    
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        repoRepository.saveRepository(repositoriesVO)
    }
    
    func readRepository(_ userName: String) -> [RepositoryVO] {
        repoRepository.readRepository(userName)
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        try await repoRepository.fetchRepository(userName)
    }
    
    func deletRepository(_ userName: String) {
        repoRepository.deleteRepository(userName)
    }
}

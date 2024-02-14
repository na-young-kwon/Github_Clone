//
//  RepositoryUseCase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation
import Factory

protocol RepoUseCaseDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO])
    func readRepository(_ userID: Int) -> [RepositoryVO]
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO]
    func deletRepository(_ userID: Int)
}

struct RepoUseCase: RepoUseCaseDelegate {
    @Injected(\.repoRepository) private var repoRepository
    
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        repoRepository.saveRepository(repositoriesVO)
    }
    
    func readRepository(_ userID: Int) -> [RepositoryVO] {
        repoRepository.readRepository(userID)
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        try await repoRepository.fetchRepository(userName)
    }
    
    func deletRepository(_ userID: Int) {
        repoRepository.deleteRepository(userID)
    }
}

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
    
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        repoRepository.saveRepository(repositoriesVO)
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        try await repoRepository.fetchRepository(userName)
    }
    
    func deletRepository(_ userName: String) {
        repoRepository.deleteRepository(userName)
    }
}

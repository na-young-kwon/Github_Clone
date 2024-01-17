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
    
    func saveRepository(_ repositoryVO: RepositoryVO) {
        let repoDTO = RepositoryDTO(vo: repositoryVO)
        repoRepository.saveRepository(repoDTO)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryVO] {
        let repoDTOs = repoRepository.fetchRepository(userName)
        return repoDTOs.map(RepositoryDTO.toVO)
    }
    
    func fetchRepositories() -> [RepositoryVO] {
        return repoRepository.fetchRepositories().map(RepositoryDTO.toVO)
    }

    func deletRepository(_ userName: String) {
        repoRepository.deleteRepository(userName)
    }
}

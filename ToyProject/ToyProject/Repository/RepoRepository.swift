//
//  RepoRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/16/24.
//

import Foundation

struct RepoRepository {
    private let networkService = NetworkService()
    private let dao = RepositoryDao()
    
    // DB에서 레포지토리 데이터 가져오는 메서드
    func getRepositoryList(id: Int) -> [RepositoryVo] {
        let repositoryList = dao.getRepository(by: id)
        
        let repoVo = repositoryList.map { RepositoryVo(id: $0.id,
                                                       ownerID: $0.ownerID,
                                                       fullName: $0.fullName,
                                                       htmlUrl: $0.htmlUrl,
                                                       starsCount: $0.starsCount,
                                                       watchersCount: $0.watchersCount,
                                                       forksCount: $0.forksCount,
                                                       language: $0.language
        )}
        return repoVo
    }
    
    // API통신을 통해 레포지토리 데이터 가져오는 메서드
    func fetchRepositoryList(forUser name: String) async throws -> [RepositoryVo] {
        let repositoryDTO = try await networkService.fetchRepositories(forUser: name)
        
        let repositoryVo = repositoryDTO.map { RepositoryVo(id: $0.id,
                                                            ownerID: $0.user.ownerID,
                                                             fullName: $0.fullName,
                                                             htmlUrl: $0.htmlUrl,
                                                             starsCount: $0.starsCount,
                                                             watchersCount: $0.watchersCount,
                                                             forksCount: $0.forksCount,
                                                             language: $0.language
        )}
        try dao.create(repositoryVo)
//        dao.compareAndDelete(username: name, repos: repositoryVo)
        return repositoryVo
    }
}

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
    func getRepositoryList(forUser name: String) -> [RepositoryVo] {
        let repositoryList = dao.getRepository(by: name)
        if repositoryList.isEmpty {
            return []
        }
        
        let repoVo = repositoryList.map { RepositoryVo(id: $0.id,
                                                       userName: $0.userName,
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
    func fetchRepositories(forUser name: String) async throws -> [RepositoryVo] {
        let repositoryList = try await networkService.fetchRepositories(forUser: name)
        dao.create(repositoryList)
        
        let repositoryVo = repositoryList.map { RepositoryVo(id: $0.id,
                                                             userName: $0.user.name,
                                                             fullName: $0.fullName,
                                                             htmlUrl: $0.htmlUrl,
                                                             starsCount: $0.starsCount,
                                                             watchersCount: $0.watchersCount,
                                                             forksCount: $0.forksCount,
                                                             language: $0.language
        )}
        return repositoryVo
    }
}

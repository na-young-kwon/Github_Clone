//
//  UserRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/12/24.
//

import Foundation

struct UserRepository {
    let networkService = NetworkService()
    
    // DB에서 유저 데이터 가져오는 메서드
    func getUser(by name: String) -> UserVo? {
        guard let user = UserRealmManager.shared.getUser(by: name) else {
            return nil
        }
        let userVo = UserVo(id: user.id,
                            userName: user.userName,
                            avatarUrl: user.avatarUrl,
                            follower: user.follower,
                            following: user.following,
                            bio: user.bio
        )
        return userVo
    }
    
    // DB에서 레포지토리 데이터 가져오는 메서드
    func getRepositoryList(forUser name: String) -> [RepositoryVo]? {
        guard let repositoryList = RepositoryRealmManager.shared.getRepository(by: name) else {
            return nil
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
    
    // API통신을 통해 유저 데이터 가져오는 메서드
    func fetchUser(by name: String) async throws -> UserVo {
        let user = try await networkService.fetchUser(forUser: name)
        UserRealmManager.shared.create(user)
        
        let userVo = UserVo(id: user.id,
                            userName: user.userName,
                            avatarUrl: user.avatarUrl,
                            follower: user.follower,
                            following: user.following,
                            bio: user.bio
        )
        return userVo
    }
    
    // API통신을 통해 레포지토리 데이터 가져오는 메서드
    func fetchRepositories(forUser name: String) async throws -> [RepositoryVo] {
        let repositoryList = try await networkService.fetchRepositories(forUser: name)
        RepositoryRealmManager.shared.create(repositoryList)
        
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

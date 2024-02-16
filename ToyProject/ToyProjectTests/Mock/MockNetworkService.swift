//
//  MockNetworkService.swift
//  ToyProjectTests
//
//  Created by nayoung kwon on 2/16/24.
//

import Foundation

class MockNetworkService: NetworkServiceDelegate {
    func fetchUser(forUser username: String) async throws -> UserDTO {
        let user = UserDTO(id: 383316,
                           userName: "test",
                           avatarUrl: "https://avatars.githubusercontent.com/u/383316?v=4",
                           followers: 48,
                           following: 0,
                           bio: "hello world")
        return user
    }
    
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        let repository = [
            RepositoryDTO(id: 12196274,
                          user: RepositoryDTO.User(userID: 383316),
                          fullName: "test/HelloWorld",
                          htmlUrl: "https://github.com/test",
                          starsCount: 6,
                          watchersCount: 6,
                          forksCount: 33,
                          language: "swift"),
            RepositoryDTO(id: 9872654,
                          user: RepositoryDTO.User(userID: 383316),
                          fullName: "test/rokehan",
                          htmlUrl: "https://github.com/test",
                          starsCount: 1,
                          watchersCount: 1,
                          forksCount: 3,
                          language: "PHP")
        ]
        return repository
    }
}

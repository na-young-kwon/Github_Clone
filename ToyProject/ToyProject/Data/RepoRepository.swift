//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import Factory

protocol RepoDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO])
    func readRepository(_ userID: Int) -> [RepositoryVO]
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO]
    func deleteRepository(_ userID: Int)
}

struct RepoRepository: RepoDelegate {
    
    @Injected(\.repositoryDAO) private var repositoryDAO
    
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        repositoryDAO.create(repositoriesVO)
    }
    
    func readRepository(_ userID: Int) -> [RepositoryVO] {
        repositoryDAO.read(userID)
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        var fetchedRepository = [RepositoryVO]()
        do {
            let fetchRepository = try await NetworkService.shared.fetchRepositories(forUser: userName).map { dto in
                return RepositoryVO(
                    id: dto.id,
                    user: RepositoryVO.User(userID: dto.user.userID),
                    fullName: dto.fullName,
                    htmlUrl: dto.htmlUrl,
                    starsCount: dto.starsCount,
                    watchersCount: dto.watchersCount,
                    forksCount: dto.forksCount,
                    language: dto.language
                )
            }
            fetchedRepository = fetchRepository
        } catch {
            print(error)
        }
        return fetchedRepository
    }
    
    func deleteRepository(_ userID: Int) {
        repositoryDAO.delete(userID)
    }
    
}

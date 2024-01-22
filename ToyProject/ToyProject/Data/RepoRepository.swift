//
//  RepoRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

protocol RepoDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO])
    func readRepository(_ userName: String) -> [RepositoryVO]
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO]
    func deleteRepository(_ userName: String)
}

struct RepoRepository: RepoDelegate {
    
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        RepositoryDAO.shared.create(repositoriesVO)
    }
    
    func readRepository(_ userName: String) -> [RepositoryVO] {
        RepositoryDAO.shared.read(userName)
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        var fetchedRepository = [RepositoryVO]()
        do {
            let fetchRepository = try await NetworkService.shared.fetchRepositories(forUser: userName).map { dto in
                return RepositoryVO(
                    id: dto.id,
                    user: RepositoryVO.User(name: dto.user.name),
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
    
    func deleteRepository(_ userName: String) {
        RepositoryDAO.shared.delete(userName)
    }
    
}

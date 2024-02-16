//
//  MockRepoRepository.swift
//  ToyProjectTests
//
//  Created by nayoung kwon on 2/16/24.
//

import Foundation

class MockRepoRepository: RepoDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO]) {
        <#code#>
    }
    
    func readRepository(_ userID: Int) -> [RepositoryVO] {
        <#code#>
    }
    
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO] {
        <#code#>
    }
    
    func deleteRepository(_ userID: Int) {
        <#code#>
    }
}

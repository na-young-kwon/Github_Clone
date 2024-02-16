//
//  MockNetworkService.swift
//  ToyProjectTests
//
//  Created by nayoung kwon on 2/16/24.
//

import Foundation

class MockNetworkService: NetworkServiceDelegate {
    func fetchUser(forUser username: String) async throws -> UserDTO {
        <#code#>
    }
    
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        <#code#>
    }
}

//
//  UserNetwork.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Alamofire
import SwiftUI

struct Constants {
    static let baseURL = "https://api.github.com/repos/"
}

// Network Layer
class NetworkService {
    
    func fetchRepository(username: String, repositoryName: String) async throws -> UserResponse {
        let urlString = "\(Constants.baseURL)\(username)/\(repositoryName)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let repository: UserResponse = try await AF.request(url)
            .serializingDecodable(UserResponse.self)
            .value

        return repository
    }
    
    func fetchRepositories(forUser username: String) async throws -> [UserResponse] {
            let urlString = "https://api.github.com/users/\(username)/repos"
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            let repositories: [UserResponse] = try await AF.request(url)
                .serializingDecodable([UserResponse].self)
                .value

            return repositories
        }
}

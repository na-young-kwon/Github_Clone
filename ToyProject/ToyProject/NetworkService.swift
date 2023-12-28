//
//  UserNetwork.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Alamofire
import SwiftUI

struct Constants {
    static let repoURL = "https://api.github.com/repos/"
    static let userURL = "https://api.github.com/users/"
}

// Network Layer
class NetworkService {
    
    /// 레포지토리목록를 받아오는 함수
    /// - Parameter username: 유저의 이름을 파라미터로 받는다.
    /// - Returns: UserReponse
    func fetchRepositories(forUser username: String) async throws -> [UserResponse] {
        let urlString = "\(Constants.userURL)\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let repositories: [UserResponse] = try await AF.request(url)
            .serializingDecodable([UserResponse].self)
            .value
        
        return repositories
    }
    
    /// 유저의 종합정보를 받아오는 함수
    /// - Parameter username: 유저이름
    /// - Returns: UserResponse
    func fetchUser(forUser username: String) async throws -> UserResponse {
        let urlString = "\(Constants.userURL)\(username)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let user: UserResponse = try await AF.request(url)
            .serializingDecodable(UserResponse.self)
            .value
        
        return user
    }
    
}

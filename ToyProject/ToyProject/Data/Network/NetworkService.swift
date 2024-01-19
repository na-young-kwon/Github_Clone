//
//  UserNetwork.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Alamofire
import SwiftUI

/// 네트워크 오류를 나타내는 커스텀 열거형
enum NetworkError: Error {
    case badURL
    case serverError(Int)
    case connectionError(Error)
    case unknownError
}

struct Constants {
    static let userURL = "https://api.github.com/users/"
}

class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchUser(forUser username: String) async throws -> UserDTO {
        guard let url = URL(string: "\(Constants.userURL)\(username)") else {
            throw NetworkError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        let token = "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"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let user: UserDTO = try await AF.request(urlRequest)
                .serializingDecodable(UserDTO.self)
                .value
            return user
        } catch {
            throw handleError(error)
        }
    }
    
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        guard let url = URL(string: "\(Constants.userURL)\(username)/repos") else {
            throw NetworkError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        let token = "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"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let repositories: [RepositoryDTO] = try await AF.request(url)
                .serializingDecodable([RepositoryDTO].self)
                .value
            return repositories
        } catch {
            throw handleError(error)
        }

    }

    private func handleError(_ error: Error) -> NetworkError {
        if let afError = error.asAFError {
            switch afError {
            case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
                return .serverError(code)
            case .sessionTaskFailed(let underlyingError):
                return .connectionError(underlyingError)
            default:
                return .unknownError
            }
        } else {
            return .unknownError
        }
    }
}

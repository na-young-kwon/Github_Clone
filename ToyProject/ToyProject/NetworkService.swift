//
//  UserNetwork.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Alamofire
import SwiftUI

// 네트워크 오류를 나타내는 커스텀 열거형
enum NetworkError: Error {
    case badURL
    case serverError(Int)
    case connectionError(Error)
    case unknownError
}

struct Constants {
    static let repoURL = "https://api.github.com/repos/"
    static let userURL = "https://api.github.com/users/"
}

class NetworkService {
    
    // 레포지토리 목록을 받아오는 함수
    func fetchRepositories(forUser username: String) async throws -> [UserResponse] {
        let urlString = "\(Constants.userURL)\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            let repositories: [UserResponse] = try await AF.request(url)
                .serializingDecodable([UserResponse].self)
                .value
            return repositories
        } catch {
            throw handleError(error)
        }
    }
    
    /// 유저의 종합정보를 받아오는 함수
    /// - Parameter username: 유저이름
    /// - Returns: UserResponse
    func fetchUser(forUser username: String) async throws -> UserResponse {
        let urlString = "\(Constants.userURL)\(username)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            let user: UserResponse = try await AF.request(url)
                .serializingDecodable(UserResponse.self)
                .value
            return user
        } catch {
            throw handleError(error)
        }
    }
    
    // 에러 처리 함수
    private func handleError(_ error: Error) -> NetworkError {
        if let afError = error.asAFError {
            // Alamofire 오류 분석 및 사용자 친화적인 메시지로 변환
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

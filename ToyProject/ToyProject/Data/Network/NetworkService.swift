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
    
    /// created by 김우섭
    /// 유저의 종합정보를 받아오는 함수
    /// - Parameter username: 유저이름
    /// - Returns: UserResponse
    func fetchUser(forUser username: String) async throws -> UserDTO {
        let urlString = "\(Constants.userURL)\(username)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            let user: UserDTO = try await AF.request(url)
                .serializingDecodable(UserDTO.self)
                .value
            return user
        } catch {
            throw handleError(error)
        }
    }
    
    /// created by 김우섭
    /// 유저의 레포지토리정보를 받아오는 함수
    /// - Parameter username: 유저이름
    /// - Returns: [RepositoryResponse]
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        let urlString = "\(Constants.userURL)\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            let repositories: [RepositoryDTO] = try await AF.request(url)
                .serializingDecodable([RepositoryDTO].self)
                .value
            return repositories
        } catch {
            throw handleError(error)
        }
    }
    
    /// created by 김우섭
    /// 에러 처리 함수
    private func handleError(_ error: Error) -> NetworkError {
        if let afError = error.asAFError {
            /// Alamofire 오류 분석 및 사용자 친화적인 메시지로 변환
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

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
    case decodingError(Error)
    
//    var description: String {
//        switch self {
//        case .badURL:
//            return "no_github_ID".getLocalizedString()
//        case let .serverError(code):
//            return "server_error".getLocalizedString(with: code)
//        case let .connectionError(error):
//            return "connection_error".getLocalizedString()
//        case .unknownError:
//            return "no_github_ID".getLocalizedString()
//        case let .decodingError(error):
//            return "디코딩 에러: \(error.localizedDescription)"
//        }
//    }
}

struct Constants {
    static let userURL = "https://api.github.com/users/"
}

class NetworkService {
    
    // 레포지토리 목록을 받아오는 함수
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO] {
        let urlString = "\(Constants.userURL)\(username)/repos"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            let repositories = try await AF
                .request(request)
                .serializingDecodable([RepositoryDTO].self)
                .value
            return repositories
        } catch {
            throw handleError(error)
        }
    }
    
    /// 유저의 종합정보를 받아오는 함수
    /// - Parameter username: 유저이름
    /// - Returns: UserResponse
    func fetchUser(forUser username: String) async throws -> UserDTO {
        let urlString = "\(Constants.userURL)\(username)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            let user = try await AF
                .request(request)
                .serializingDecodable(UserDTO.self)
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
            case let .responseValidationFailed(reason: .unacceptableStatusCode(code)):
                return .serverError(code)
            case let .sessionTaskFailed(error):
                return .connectionError(error)
            case let .responseSerializationFailed(reason: .decodingFailed(error: error)):
                return .decodingError(error)
            default:
                return .unknownError
            }
        } else {
            return .unknownError
        }
    }
}

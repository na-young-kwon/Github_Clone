//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import SwiftUI
import Alamofire

// 마지막 수정자: nayoung kwon

class UserViewModel: ObservableObject {
    @Published var user: UserResponse?
    @Published var repositories: [RepositoryResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var usecase = UserUsecase()
    
    @MainActor
    func fetchUser(forUser userName: String) async {
        isLoading = true
        do {
            user = try await usecase.getUser(forUser: userName)
            await fetchRepositories(forUser: userName) // 여기서 fetchRepositories 호출
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
    
    @MainActor
    func fetchRepositories(forUser userName: String) async {
        do {
            repositories = try await usecase.getRepositories(forUser: userName)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
    }
}

extension UserViewModel {
    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .badURL:
            return "no_github_ID".getLocalizedString()
        case .serverError(let code):
            return "server_error".getLocalizedString(with: code)
        case .connectionError:
            return "connection_error".getLocalizedString()
        case .unknownError:
            return "no_github_ID".getLocalizedString()
        }
    }
}

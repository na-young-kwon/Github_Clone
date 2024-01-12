//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserResponse?
    @Published var repositories: [RepositoryResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var networkUseCase = NetworkUseCase()
    
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    func networkFetchUser(forUser userName: String) async {
        isLoading = true

        let savedUsers = fetchUser(userName)
        
        if savedUsers.isEmpty {
            // Realm에 데이터가 없으면 네트워크에서 데이터를 가져옴
            do {
                user = try await networkUseCase.getUser(forUser: userName)
                
                await networkFetchRepositories(forUser: userName)
                guard let fetchedUser = user else { return }
                saveUser(fetchedUser)
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        } else {
            // Realm에 데이터가 있으면 그 데이터를 사용
            user = savedUsers.first
            await networkFetchRepositories(forUser: userName)
        }

        isLoading = false
    }

    
    func networkFetchRepositories(forUser userName: String) async {
        // Realm에서 사용자의 저장소 데이터를 먼저 확인
        let savedRepositories = fetchRepositories(userName)
        
        if savedRepositories.isEmpty {
            // 데이터가 없으면 API 호출
            do {
                repositories = try await networkUseCase.getRepositories(forUser: userName)
                for repository in repositories {
                    saveRepository(repository)  // 새로운 데이터 저장
                }
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        } else {
            // 저장된 데이터 사용
            repositories = savedRepositories
        }
    }
    
    func saveUser(_ userResponse: UserResponse) {
        userUseCase.saveUser(userResponse)
    }
    
    func saveRepository(_ repositoryResponse: RepositoryResponse) {
        repoUseCase.saveRepository(repositoryResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserResponse] {
        userUseCase.fetchUser(userName)
    }
    
    func fetchRepositories(_ userName: String) -> [RepositoryResponse] {
        repoUseCase.fetchUser(userName)
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

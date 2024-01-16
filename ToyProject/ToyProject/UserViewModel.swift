//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserDTO?
    @Published var repositories: [RepositoryDTO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkUseCase: NetworkUseCase = NetworkUseCase()
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    func networkFetchUser(forUser userName: String) async {
        isLoading = true
        let savedUsers = fetchUser(userName)
        
        if savedUsers.isEmpty {
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
            user = savedUsers.first
            await networkFetchRepositories(forUser: userName)
        }
        isLoading = false
    }
    
    func networkFetchRepositories(forUser userName: String) async {
        let savedRepositories = fetchRepositories(userName)
        
        if savedRepositories.isEmpty {
            do {
                repositories = try await networkUseCase.getRepositories(forUser: userName)
                for repository in repositories {
                    saveRepository(repository)
                }
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        } else {
            repositories = savedRepositories
        }
    }
    
    ///  Created by 김우섭
    /// 유저를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 유저를 Realm에 저장
    func saveUser(_ userResponse: UserDTO) {
        userUseCase.saveUser(userResponse)
    }
    
    ///  Created by 김우섭
    /// 레포지토리를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 레포지토리를 Realm에 저장
    func saveRepository(_ repositoryResponse: RepositoryDTO) {
        repoUseCase.saveRepository(repositoryResponse)
    }
    
    ///  Created by 김우섭
    /// userName에 맞는 특정 유저를 Realm에서 불러오는 함수
    /// - Parameter userName: userName
    /// - Returns: userName에 해당하는 UserResponse
    func fetchUser(_ userName: String) -> [UserDTO] {
        userUseCase.fetchUser(userName)
    }
    
    ///  Created by 김우섭
    /// userName에 맞는 특정 레포지토리를 Realm에서 불러오는 함수
    /// - Parameter userName: 특정 userName
    /// - Returns: userName에 해당하는 [RepositoryResponse]
    func fetchRepositories(_ userName: String) -> [RepositoryDTO] {
        repoUseCase.fetchRepository(userName)
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

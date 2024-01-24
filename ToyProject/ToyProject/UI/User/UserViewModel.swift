//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim  on 1/18/24.
//

import SwiftUI
import Alamofire

class UserViewModel: ObservableObject {
    @Published var user: UserVO?
    @Published var repositories: [RepositoryVO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    @MainActor
    public func dbCheck(_ userName: String) {
        user = readUser(userName)
        guard let user = user else { return }
        repositories = readRepository(user.id)
    }
    
    @MainActor
    public func apiCheck(_ userName: String) async {
        await fetchUser(userName)
        await fetchRepository(userName)
    }
    
    @MainActor
    private func fetchUser(_ userName: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            user = try await userUseCase.fetchUser(userName)
            guard let user = user else { return }
            saveUser(user)
        } catch {
            handleNetworkError(error)
        }
    }
    
    @MainActor
    private func fetchRepository(_ userName: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedRepo = try await repoUseCase.fetchRepository(userName)
            repositories = fetchedRepo
            Set(fetchedRepo.map { $0.user.userID }).forEach { userId in
                deleteRepository(userId)
            }
            saveRepositories(repositories)
        } catch {
            handleNetworkError(error)
        }
    }
    
    private func readUser(_ userName: String) -> UserVO? {
        userUseCase.readUser(userName)
    }
    
    private func readRepository(_ userID: Int) -> [RepositoryVO] {
        repoUseCase.readRepository(userID)
    }
    
    private func saveUser(_ userVO: UserVO) {
        userUseCase.saveUser(userVO)
    }
    
    private func saveRepositories(_ repositoriesVO: [RepositoryVO]) {
        repoUseCase.saveRepository(repositoriesVO)
    }
    
    private func deleteRepository(_ userID: Int) {
        repoUseCase.deletRepository(userID)
    }
    
}

extension UserViewModel {
    private func handleNetworkError(_ error: Error) {
        if let networkError = error as? NetworkError {
            errorMessage = errorMessage(for: networkError)
        } else {
            errorMessage = "no_github_ID".getLocalizedString()
        }
    }
    
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

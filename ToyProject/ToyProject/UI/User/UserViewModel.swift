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
    func checkUser(_ userName: String) async {
        user = readUser(userName)
        await fetchUser(userName)
    }
    
    @MainActor
    func checkRepository(_ userName: String) async {
        let userID = readUser(userName)?.id
        guard let userID = userID else { return }
        repositories = readRepository(userID)
        await fetchRepository(userName)
    }
    
    @MainActor
    func fetchUser(_ userName: String) async {
        isLoading = true
        do {
            user = try await userUseCase.fetchUser(userName)
            guard let user = user else { return }
            deleteRepository(user.id)
            saveUser(user)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
    
    @MainActor
    func fetchRepository(_ userName: String) async {
        isLoading = true
        do {
            let fetchedRepo = try await repoUseCase.fetchRepository(userName)
            repositories = fetchedRepo
            saveRepositories(repositories)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
    
    func readUser(_ userName: String) -> UserVO? {
        userUseCase.readUser(userName)
    }
    
    func readRepository(_ userID: Int) -> [RepositoryVO] {
        repoUseCase.readRepository(userID)
    }
    
    func saveUser(_ userVO: UserVO) {
        userUseCase.saveUser(userVO)
    }
    
    func saveRepositories(_ repositoriesVO: [RepositoryVO]) {
        repoUseCase.saveRepository(repositoriesVO)
    }
    
    func deleteRepository(_ userID: Int) {
        repoUseCase.deletRepository(userID)
    }
    
}

extension UserViewModel {
    func errorMessage(for error: NetworkError) -> String {
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
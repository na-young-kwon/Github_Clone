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
    @Published var errorMessage: String = ""
    
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    @MainActor
    func fetchUser(_ userName: String) async {
        isLoading = true
        let fetchedUser = await userUseCase.fetchUser(userName)
        user = fetchedUser
        guard let user = user else { return }
        saveUser(user)
        isLoading = false
    }
    
    @MainActor
    func fetchRepository(_ userName: String) async {
        isLoading = true
        let fetchedRepo = await repoUseCase.fetchRepository(userName)
        repositories = fetchedRepo
        saveRepositories(repositories)
        isLoading = false
    }
    
    func saveUser(_ userVO: UserVO) {
        userUseCase.saveUser(userVO)
    }
    
    func saveRepositories(_ repositoriesVO: [RepositoryVO]) {
        repoUseCase.saveRepository(repositoriesVO)
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

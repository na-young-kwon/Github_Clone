//
//  UserViewModel.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var repositories: [UserResponse] = []
    @Published var isLoading = false

    private var repositoryUseCase = RepositoryUseCase()

    func fetchRepositories(forUser username: String) async {
        isLoading = true
        do {
            repositories = try await repositoryUseCase.getRepositories(forUser: username)
        } catch {
            // 에러 처리
            print("Error fetching repositories: \(error)")
        }
        isLoading = false
    }
}

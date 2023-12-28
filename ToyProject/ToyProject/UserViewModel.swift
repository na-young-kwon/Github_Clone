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
    @Published var user: UserResponse?
    @Published var repositories: [UserResponse] = []
    @Published var isLoading = true

    private var repositoryUseCase = RepositoryUseCase()

    func fetchRepositories(forUser username: String) async {
        do {
            repositories = try await repositoryUseCase.getRepositories(forUser: username)
        } catch {
            // 에러 처리
            print("레포지토리를 받아오는 데 실패했습니다. - \(error)")
        }
        isLoading = false
    }
    
    func fetchUser(forUser username: String) async {
        do {
            user = try await repositoryUseCase.getUser(foruser: username)
        } catch {
            print("유저의 종합정보를 받아오는 데 실패했습니다 - \(error)")
        }
        isLoading = false
    }
}

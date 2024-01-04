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
    @Published var repositories: [UserResponse] = []
    @Published var isLoading = false
    @Published var avatarImage: UIImage?
    
    // let 으로 변경
    private let repositoryUseCase = RepositoryUseCase()
    
    private func fetchRepositories(forUser username: String) async {
        do {
            repositories = try await repositoryUseCase.getRepositories(forUser: username)
        } catch {
            print("레포지토리를 받아오는 데 실패했습니다. - \(error)")
        }
        isLoading = false // 모든 작업이 끝나면 isLoading 상태를 업데이트합니다.
    }
    
    // 이거 수정하는게 좋을 듯
    func fetchUser(forUser username: String) async {
        isLoading = true
        do {
            let userResponse = try await repositoryUseCase.getUser(forUser: username)
            user = userResponse
            repositoryUseCase.saveSearchHistory(SearchHistory(id: userResponse.id, text: userResponse.login ?? "login id 없음"))
        } catch {
            print("유저의 종합정보를 받아오는 데 실패했습니다 - \(error)")
        }
        await fetchRepositories(forUser: username) // 여기서도 비동기 호출을 진행합니다.
    }
}


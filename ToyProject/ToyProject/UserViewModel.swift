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
    @Published var errorMessage: String?
    
    private var repositoryUseCase = RepositoryUseCase()
    
    func fetchUser(forUser username: String) async {
          isLoading = true
          do {
              user = try await repositoryUseCase.getUser(foruser: username)
              await fetchRepositories(forUser: username) // 여기서 fetchRepositories 호출
          } catch let error as NetworkError {
              errorMessage = errorMessage(for: error)
          } catch {
              errorMessage = "깃허브 ID가 없습니다. 🙅🏻‍♂️"
          }
          isLoading = false
      }

      func fetchRepositories(forUser username: String) async {
          do {
              repositories = try await repositoryUseCase.getRepositories(forUser: username)
              print("Repositories 정보 가져오기 성공: \(repositories)")
          } catch let error as NetworkError {
              errorMessage = errorMessage(for: error)
          } catch {
              errorMessage = "깃허브 ID가 없습니다. 🙅🏻‍♂️"
          }
      }
    
    func saveSearch(_ searchHistory: SearchHistory) {
        repositoryUseCase.saveSearchText(searchHistory)
    }
}

extension UserViewModel {
    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .badURL:
            return "깃허브 ID가 없습니다. 🙅🏻‍♂️"
        case .serverError(let code):
            return "서버 오류가 발생했습니다. 오류 코드: \(code)"
        case .connectionError:
            return "네트워크 연결 오류가 발생했습니다."
        case .unknownError:
            return "깃허브 ID가 없습니다. 🙅🏻‍♂️"
        }
    }
}

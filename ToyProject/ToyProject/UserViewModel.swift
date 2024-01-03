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
    
    //    func fetchRepositories(forUser username: String) async {
    //        do {
    //            repositories = try await repositoryUseCase.getRepositories(forUser: username)
    //        } catch {
    //            print("레포지토리를 받아오는 데 실패했습니다. - \(error)")
    //        }
    //        isLoading = false
    //    }
    
//    func fetchRepositories(forUser username: String) async {
//        isLoading = true
//        do {
//            repositories = try await repositoryUseCase.networkService.fetchRepositories(forUser: username)
//            errorMessage = nil // 성공 시 오류 메시지 초기화
//        } catch {
//            errorMessage = "레포지토리를 받아오는 데 실패했습니다: \(error.localizedDescription)"
//            print(errorMessage!)
//        }
//        isLoading = false
//    }
    
//    func fetchRepositories(forUser username: String) async {
//        isLoading = true
//        do {
//            repositories = try await repositoryUseCase.getRepositories(forUser: username)
//            errorMessage = nil // 성공 시 오류 메시지 초기화
//            print("this is \(repositories)")
//        } catch let error as NetworkError {
//            errorMessage = errorMessage(for: error)
//        } catch {
//            errorMessage = "알 수 없는 오류가 발생했습니다."
//        }
//        isLoading = false
//    }
    
    //    func fetchUser(forUser username: String) async {
    //        isLoading = true
    //        do {
    //            user = try await repositoryUseCase.getUser(foruser: username)
    //        } catch {
    //            print("유저의 종합정보를 받아오는 데 실패했습니다 - \(error)")
    //        }
    //        await fetchRepositories(forUser: username)
    //    }
    //
    
    func fetchUser(forUser username: String) async {
          isLoading = true
          do {
              user = try await repositoryUseCase.getUser(foruser: username)
              print("User 정보 가져오기 성공: \(user)")
              await fetchRepositories(forUser: username) // 여기서 fetchRepositories 호출
          } catch let error as NetworkError {
              errorMessage = errorMessage(for: error)
          } catch {
              errorMessage = "알 수 없는 오류가 발생했습니다."
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
              errorMessage = "알 수 없는 오류가 발생했습니다."
          }
      }
    
    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .badURL:
            return "잘못된 URL입니다."
        case .serverError(let code):
            return "서버 오류가 발생했습니다. 오류 코드: \(code)"
        case .connectionError:
            return "네트워크 연결 오류가 발생했습니다."
        case .unknownError:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import SwiftUI
import Alamofire

// 마지막 수정자: nayoung kwon

class UserViewModel: ObservableObject {
    @Published var user: UserVo?
    @Published var repositories: [RepositoryVo] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    private let usecase = UserUsecase()
  
    func getUser(forUser userName: String) {
        Task {
            let user = usecase.getUser(forUser: userName)
            
            DispatchQueue.main.async {
                self.user = user
                if let id = user?.id {
                    let repositories = self.usecase.getRepositoryList(id: id)
                    self.repositories = repositories
                }
            }
            await fetchUserAndRepo(forUser: userName)
        }
    }
    
    func fetchUserAndRepo(forUser userName: String) async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.updateUser(forUser: userName)
            }
            group.addTask {
                await self.updateRepository(forUser: userName)
            }
        }
    }
    
    @MainActor
    private func updateUser(forUser userName: String) async {
        isLoading = true
        do {
            user = try await usecase.fetchUser(forUser: userName)
        } catch let error as NetworkError {
            switch error {
            case .badURL, .serverError, .connectionError, .unknownError:
                errorMessage = errorMessage(for: error)
            case .decodingError(let error):
                errorMessage = "no_github_ID".getLocalizedString()
                print(error)
            }
        } catch RealmError.failToCreateUser(user: let user) {
            self.user = user
            showAlert = true
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
    
    @MainActor
    private func updateRepository(forUser userName: String) async {
        isLoading = true
        do {
            repositories = try await usecase.fetchRepositoryList(forUser: userName)
        } catch let error as NetworkError {
            switch error {
            case .badURL, .serverError, .connectionError, .unknownError:
                errorMessage = errorMessage(for: error)
            case .decodingError(let error):
                errorMessage = "no_github_ID".getLocalizedString()
                print(error)
            }
        } catch RealmError.failToCreateRepository {
            print("레포지터리 저장 실패")
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
}

extension UserViewModel {
    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .badURL:
            return "no_github_ID".getLocalizedString()
        case let .serverError(code):
            return "server_error".getLocalizedString(with: code)
        case .connectionError:
            return "connection_error".getLocalizedString()
        case .unknownError:
            return "no_github_ID".getLocalizedString()
        case let .decodingError(error):
            return "디코딩 에러: \(error.localizedDescription)"
        }
    }
}

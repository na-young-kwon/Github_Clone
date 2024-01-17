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
        user = usecase.getUser(forUser: userName)
    }
    
    @MainActor
    func updateUser(forUser userName: String) async {
        isLoading = true
        do {
            user = try await usecase.fetchUser(forUser: userName)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch RealmError.failToCreateUser(user: let user) {
            self.user = user
            showAlert = true
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
        isLoading = false
    }
    
    func getRepository(forUser userName: String) {
        repositories = usecase.getRepositoryList(forUser: userName)
    }
    
    @MainActor
    func updateRepository(forUser userName: String) async {
        isLoading = true
        do {
            repositories = try await usecase.fetchRepositoryList(forUser: userName)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
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

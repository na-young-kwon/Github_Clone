//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim  on 1/18/24.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserVO?
    @Published var repositories: [RepositoryVO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    func dbFetchUser(userName: String) {
        let dbUser = fetchUser(userName)
        user = dbUser
    }
    
    func dbFetchRepository(userName: String) {
        let dbRepository = fetchRepository(userName)
        repositories = dbRepository
        print(dbRepository.count)
    }
    
    /// API User Fetch
    func networkFetchUser(_ userName: String) async {
        do {
            let fetchedUserDTO = try await NetworkService().fetchUser(forUser: userName)
            let fetchedUserVO = UserDTO.toVO(fetchedUserDTO)
            user = fetchedUserVO
            saveUser(fetchedUserVO)
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
    }
    
    /// API Repository Fetch
    func networkFetchRepository(_ userName: String) async {
        do {
            let fetchRepositoryDTO = try await NetworkService().fetchRepositories(forUser: userName)
            RepositoryDAO.shared.delete(userName)
            // DTO를 VO로 변환합니다.
            let fetchedRepositoryVO = fetchRepositoryDTO.map { dto in
                RepositoryVO(
                    id: dto.id,
                    user: RepositoryVO.User(name: dto.user.name),
                    fullName: dto.fullName,
                    htmlUrl: dto.htmlUrl,
                    starsCount: dto.starsCount,
                    watchersCount: dto.watchersCount,
                    forksCount: dto.forksCount,
                    language: dto.language
                )
            }
            fetchedRepositoryVO.forEach { saveRepository($0) }
            
            repositories = fetchedRepositoryVO
        } catch let error as NetworkError {
            errorMessage = errorMessage(for: error)
        } catch {
            errorMessage = "no_github_ID".getLocalizedString()
        }
    }
    
    
    /// 유저를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 유저를 Realm에 저장
    func saveUser(_ userVO: UserVO) {
        userUseCase.saveUser(userVO)
    }
    
    /// 레포지토리를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 레포지토리를 Realm에 저장
    func saveRepository(_ repositoryVO: RepositoryVO) {
        repoUseCase.saveRepository(repositoryVO)
    }
    
    /// userName에 맞는 특정 유저를 Realm에서 불러오는 함수
    /// - Parameter userName: userName
    /// - Returns: userName에 해당하는 UserResponse
    func fetchUser(_ userName: String) -> UserVO? {
        userUseCase.fetchUser(userName)
    }
    
    /// userName에 맞는 특정 레포지토리를 Realm에서 불러오는 함수
    /// - Parameter userName: 특정 userName
    /// - Returns: userName에 해당하는 [RepositoryResponse]
    func fetchRepositories(_ userName: String) -> [RepositoryVO] {
        repoUseCase.fetchRepository(userName)
    }
    
    func fetchRepository(_ userName: String) -> [RepositoryVO] {
        repoUseCase.fetchRepository(userName)
    }
}

extension UserViewModel {
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

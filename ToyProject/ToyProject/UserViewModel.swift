//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserVO?
    @Published var repositories: [RepositoryVO] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkUseCase: NetworkUseCase = NetworkUseCase()
    private let userUseCase: UserUseCase = UserUseCase()
    private let repoUseCase: RepoUseCase = RepoUseCase()
    
    /*
     1. 저장된 유저를 읽어온다.
     2. 저장된 유저가 Realm에 있는 지 없는 지 확인한다.
     3. 있으면 읽어온 유저가 유저이다.
     4. 없으면 network를 해서 유저를 불러오고, 그 DTO를 VO에 넣고
     5. 유저를 fetchedVO로 할당하고, 그 유저를 저장한다.
     여기서 이슈 🚨
     ✋🏻 그러면 DB에 데이터가 있을 때, 그 DB 데이터는 업데이트가 안되고, 계속 그 데이터만 불러올텐데,
     서버의 Data가 업데이트됐을 때, 그 DB 데이터는 어떻게 업데이트 시킬 껀데?
     */
    
    
    func networkFetchUser(forUser userName: String) async {
        isLoading = true
        let savedUser = userUseCase.fetchUser(userName)
        
        if savedUser == nil {
            do {
                let fetchedUserDTO = try await networkUseCase.getUser(forUser: userName)
                let fetchedUserVO = UserDTO.toVO(fetchedUserDTO)
                user = fetchedUserVO
                saveUser(fetchedUserVO)
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        } else {
            user = savedUser
            do {
                let fetchedUserDTO = try await networkUseCase.getUser(forUser: userName)
                let fetchedUserVO = UserDTO.toVO(fetchedUserDTO)
                user = fetchedUserVO
                saveUser(fetchedUserVO)
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        }
        isLoading = false
    }
    
    func networkFetchRepositories(forUser userName: String) async {
        let savedRepositories = fetchRepositories(userName)
        
        if savedRepositories.isEmpty {
            do {
                let fetchedRepositoryDTOs = try await networkUseCase.getRepositories(forUser: userName)
                let fetchedRepositories = fetchedRepositoryDTOs.map(RepositoryDTO.toVO)
                repositories = fetchedRepositories
                for repositoryVO in fetchedRepositories {
                    saveRepository(repositoryVO)
                }
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        } else {
            repositories = savedRepositories
            do {
                let fetchedRepositoryDTOs = try await networkUseCase.getRepositories(forUser: userName)
                let fetchedRepositories = fetchedRepositoryDTOs.map(RepositoryDTO.toVO)
                repositories = fetchedRepositories
                for repositoryVO in fetchedRepositories {
                    saveRepository(repositoryVO)
                }
            } catch let error as NetworkError {
                errorMessage = errorMessage(for: error)
            } catch {
                errorMessage = "no_github_ID".getLocalizedString()
            }
        }
    }
    
    ///  Created by 김우섭
    /// 유저를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 유저를 Realm에 저장
    func saveUser(_ userVO: UserVO) {
        userUseCase.saveUser(userVO)
    }
    
    ///  Created by 김우섭
    /// 레포지토리를 Realm에 저장하는 함수
    /// - Parameter userResponse: 네트워크통신을 통한 레포지토리를 Realm에 저장
    func saveRepository(_ repositoryVO: RepositoryVO) {
        repoUseCase.saveRepository(repositoryVO)
    }
    
    ///  Created by 김우섭
    /// userName에 맞는 특정 유저를 Realm에서 불러오는 함수
    /// - Parameter userName: userName
    /// - Returns: userName에 해당하는 UserResponse
    func fetchUser(_ userName: String) -> UserVO? {
        userUseCase.fetchUser(userName)
    }
    
    ///  Created by 김우섭
    /// userName에 맞는 특정 레포지토리를 Realm에서 불러오는 함수
    /// - Parameter userName: 특정 userName
    /// - Returns: userName에 해당하는 [RepositoryResponse]
    func fetchRepositories(_ userName: String) -> [RepositoryVO] {
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

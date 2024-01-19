//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

protocol UserDelegate {
    func saveUser(_ userVO: UserVO)
    func fetchUser(_ userName: String) async -> UserVO?
    func readAllUser() -> [UserVO]
    func deleteUser(_ userName: String)
}

struct UserRepository: UserDelegate {
    
    func saveUser(_ userVO: UserVO) {
        UserDAO.shared.create(userVO)
    }
    
    func fetchUser(_ userName: String) async -> UserVO? {
        var userVO: UserVO?
        do {
            let fetchUser = try await NetworkService.shared.fetchUser(forUser: userName)
            let fetchedUser = UserVO(
                id: fetchUser.id,
                userName: fetchUser.userName,
                avatarUrl: fetchUser.avatarUrl,
                followers: fetchUser.followers,
                following: fetchUser.following,
                bio: fetchUser.bio ?? ""
            )
            userVO = fetchedUser
//        } catch let error as NetworkError {
//            switch error {
//            case .badURL, .serverError, .connectionError, .unknownError:
//                UserViewModel().errorMessage(for: error)
//            }
        } catch {
            print(error)
        }
        return userVO
    }
    
    func readAllUser() -> [UserVO] {
        UserDAO.shared.readAll()
    }
    
    func deleteUser(_ userName: String) {
        UserDAO.shared.delete(userName)
    }
    
}

//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

protocol UserDelegate {
    func saveUser(_ userVO: UserVO)
    func fetchUser(_ userName: String) async throws -> UserVO?
    func readUser(_ userName: String) -> UserVO?
    func readAllUser() -> [UserVO]
    func deleteUser(_ userName: String)
}

struct UserRepository: UserDelegate {
    
    func saveUser(_ userVO: UserVO) {
        UserDAO.shared.create(userVO)
    }
    
    func fetchUser(_ userName: String) async throws -> UserVO? {
        var userVO: UserVO?
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
        return userVO
    }
    
    func readUser(_ userName: String) -> UserVO? {
        UserDAO.shared.read(userName)
    }
    
    func readAllUser() -> [UserVO] {
        UserDAO.shared.readAll()
    }
    
    func deleteUser(_ userName: String) {
        UserDAO.shared.delete(userName)
    }
    
}

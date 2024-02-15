//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import Factory

struct UserRepository: UserDelegate {
    
    @Injected(\.userDAO) private var userDAO
    
    func saveUser(_ userVO: UserVO) {
        userDAO.create(userVO)
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
        userDAO.read(userName)
    }
    
    func readAllUser() -> [UserVO] {
        userDAO.readAll()
    }
    
    func deleteUser(_ userName: String) {
        userDAO.delete(userName)
    }
    
}

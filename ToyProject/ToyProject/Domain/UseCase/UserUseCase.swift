//
//  UserUseCase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

struct UserUseCase {
    private let userRepository: UserRepository = UserRepository()
    
    func fetchUser(_ userName: String) async throws -> UserVO? {
        try await userRepository.fetchUser(userName)
    }
    
    func saveUser(_ userVO: UserVO) {
        userRepository.saveUser(userVO)
    }
    
    func readUser(_ userName: String) -> UserVO? {
        userRepository.readUser(userName)
    }
    
    func readAllUser() -> [UserVO] {
        userRepository.readAllUser()
    }
    
    func deleteUser(_ userName: String) {
        userRepository.deleteUser(userName)
    }
}
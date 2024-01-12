//
//  UserUseCase.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

struct UserUseCase {
    private let userRepository: UserRepository = UserRepository()
    
    func saveUser(_ userResponse: UserResponse) {
        userRepository.saveUser(userResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserResponse] {
        return userRepository.fetchUser(userName)
    }
    
    func fetchUsers() -> [UserResponse] {
        return userRepository.fetchUsers()
    }
    
    func deleteUser(_ userName: String) {
        userRepository.deleteUser(userName)
    }
}

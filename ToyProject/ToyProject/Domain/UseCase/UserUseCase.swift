//
//  UserUseCase.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

/// created by 김우섭
struct UserUseCase {
    private let userRepository: UserRepository = UserRepository()
    
    func saveUser(_ userResponse: UserDTO) {
        userRepository.saveUser(userResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserDTO] {
        return userRepository.fetchUser(userName)
    }
    
    func fetchUsers() -> [UserDTO] {
        return userRepository.fetchUsers()
    }
    
    func deleteUser(_ userName: String) {
        userRepository.deleteUser(userName)
    }
}

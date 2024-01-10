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
    
    func fetchUser() -> [UserResponse] {
        return userRepository.fetchUser()
    }
    
    func deleteUser(_ userResponse: UserResponse) {
        userRepository.deleteUser(userResponse)
    }
}

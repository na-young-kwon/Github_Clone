//
//  UserUseCase.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

struct UserUseCase {
    private let repository: UserRepository = UserRepository()
    
    func saveUser(_ userResponse: UserResponse) {
        repository.saveUser(userResponse)
    }
    
    func fetchUser() -> [UserResponse] {
        return repository.fetchUser()
    }
    
    func deleteUser(_ userResponse: UserResponse) {
        repository.deleteUser(userResponse)
    }
}

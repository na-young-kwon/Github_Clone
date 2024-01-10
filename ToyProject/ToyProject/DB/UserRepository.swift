//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

protocol UserDelegate {
    func saveUser(_ userResponse: UserResponse)
    func fetchUser() -> [UserResponse]
    func deleteUser(_ userResponse: UserResponse)
}

struct UserRepository: UserDelegate {
    func saveUser(_ userResponse: UserResponse) {
        UserRealmManager.shared.create(userResponse)
    }
    
    func fetchUser() -> [UserResponse] {
        UserRealmManager.shared.read()
    }
    
    func deleteUser(_ userResponse: UserResponse) {
        UserRealmManager.shared.delete(userResponse)
    }
}

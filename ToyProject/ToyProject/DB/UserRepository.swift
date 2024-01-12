//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation

protocol UserDelegate {
    func saveUser(_ userResponse: UserResponse)
    func fetchUser(_ userName: String) -> [UserResponse]
    func deleteUser(_ userResponse: UserResponse)
}

struct UserRepository: UserDelegate {
    func saveUser(_ userResponse: UserResponse) {
        UserRealmManager.shared.create(userResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserResponse] {
        UserRealmManager.shared.read(userName)
    }
    
    func deleteUser(_ userResponse: UserResponse) {
        UserRealmManager.shared.delete(userResponse)
    }
}

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
    func fetchUsers() -> [UserResponse]
    func deleteUser(_ userName: String)
}

struct UserRepository: UserDelegate {
    
    func saveUser(_ userResponse: UserResponse) {
        UserRealmManager.shared.create(userResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserResponse] {
        UserRealmManager.shared.read(userName)
    }
    
    func fetchUsers() -> [UserResponse] {
        UserRealmManager.shared.readAll()
    }
    
    func deleteUser(_ userName: String) {
        UserRealmManager.shared.delete(userName)
    }
}

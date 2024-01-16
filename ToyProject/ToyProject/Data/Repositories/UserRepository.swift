//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
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

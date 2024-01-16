//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
protocol UserDelegate {
    func saveUser(_ userResponse: UserDTO)
    func fetchUser(_ userName: String) -> [UserDTO]
    func fetchUsers() -> [UserDTO]
    func deleteUser(_ userName: String)
}

struct UserRepository: UserDelegate {
    
    func saveUser(_ userResponse: UserDTO) {
        UserRealmManager.shared.create(userResponse)
    }
    
    func fetchUser(_ userName: String) -> [UserDTO] {
        UserRealmManager.shared.read(userName)
    }
    
    func fetchUsers() -> [UserDTO] {
        UserRealmManager.shared.readAll()
    }
    
    func deleteUser(_ userName: String) {
        UserRealmManager.shared.delete(userName)
    }
}

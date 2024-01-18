//
//  UserRepository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation

/// created by 김우섭
protocol UserDelegate {
    func saveUser(_ userDTO: UserDTO)
    func fetchUser(_ userName: String) -> UserDTO? 
    func fetchUsers() -> [UserDTO]
    func deleteUser(_ userName: String)
}

struct UserRepository: UserDelegate {
    
    func saveUser(_ userDTO: UserDTO) {
        UserDAO.shared.create(userDTO)
    }
    
    func fetchUser(_ userName: String) -> UserDTO? {
        UserDAO.shared.read(userName)
    }
    
    func fetchUsers() -> [UserDTO] {
        UserDAO.shared.readAll()
    }
    
    func deleteUser(_ userName: String) {
        UserDAO.shared.delete(userName)
    }
}

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
    
    func saveUser(_ userVO: UserVO) {
        let userDTO = UserDTO(vo: userVO)
        userRepository.saveUser(userDTO)
    }
    
    func fetchUser(_ userName: String) -> UserVO? {
        let userDTOs = userRepository.fetchUser(userName)
        return userDTOs.map(UserDTO.toVO)
    }

    
    func fetchUsers() -> [UserVO] {
        return userRepository.fetchUsers().map(UserDTO.toVO)
    }
    
    func deleteUser(_ userName: String) {
        userRepository.deleteUser(userName)
    }
}

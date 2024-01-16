//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchUsecase {
    private let repository: UserRepository = UserRepository()

    func getAllUsers() -> [UserVo] {
        return repository.getAllUsers()
    }
    
    func deleteUser(_ user: UserVo) {
        repository.deleteUser(user)
    }
}

//
//  SearchUsecase.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchUsecase {
    private let repository: UserRepository = UserRepository()

    func getAllUser() -> [UserVo] {
        return repository.getAllUser()
    }
    
    func deleteUser(id: Int) {
        repository.deleteUser(id: id)
    }
}

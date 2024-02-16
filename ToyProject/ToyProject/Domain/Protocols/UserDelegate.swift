//
//  UserDelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol UserDelegate {
    func saveUser(_ userVO: UserVO)
    func fetchUser(_ userName: String) async throws -> UserVO?
    func readUser(_ userName: String) -> UserVO?
    func readAllUser() -> [UserVO]
    func deleteUser(_ userName: String)
}

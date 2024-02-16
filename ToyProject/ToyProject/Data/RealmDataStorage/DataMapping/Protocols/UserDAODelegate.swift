//
//  UserDAODelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol UserDAODelegate {
    func create(_ userVO: UserVO)
    func readAll() -> [UserVO]
    func read(_ userName: String) -> UserVO?
    func delete(_ userName: String)
}

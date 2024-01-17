//
//  RealmError.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/16/24.
//

import Foundation

enum RealmError: Error {
    case failToCreateUser(user: UserVo)
    case failToCreateRepository
}

//
//  User.swift
//  ToyProject
//
//  Created by woosub kim  on 1/16/24.
//

import Foundation

struct UserVO: Hashable, Identifiable {
    let id: Int
    let userName: String
    let avatarUrl: String
    let followers: Int
    let following: Int
    let bio: String?
}

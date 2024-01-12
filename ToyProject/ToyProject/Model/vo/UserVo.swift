//
//  UserVo.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/12/24.
//

import Foundation

struct UserVo: Hashable {
    let id: Int
    let userName: String
    let avatarUrl: String
    let follower: Int
    let following: Int
    let bio: String?
}

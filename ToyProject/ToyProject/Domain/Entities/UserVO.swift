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

// UserVO에 UserDTO로 변환하는 초기화 메서드 추가
extension UserVO {
    init(dto: UserDTO) {
        self.id = dto.id
        self.userName = dto.userName
        self.avatarUrl = dto.avatarUrl
        self.followers = dto.followers
        self.following = dto.following
        self.bio = dto.bio
    }
}

//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

struct UserDTO: Codable, Hashable {
    let id: Int
    let userName: String
    let avatarUrl: String
    let followers: Int
    let following: Int
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id, bio
        case userName = "login"
        case avatarUrl = "avatar_url"
        case followers
        case following
    }
}

// UserDTO에 UserVO로 변환하는 메서드 추가
extension UserDTO {
    static func toVO(_ dto: UserDTO) -> UserVO {
        return UserVO(
            id: dto.id,
            userName: dto.userName,
            avatarUrl: dto.avatarUrl,
            followers: dto.followers,
            following: dto.following,
            bio: dto.bio
        )
    }
}

// UserVO 객체를 받아 UserDTO 객체를 생성
extension UserDTO {
    init(vo: UserVO) {
        self.id = vo.id
        self.userName = vo.userName
        self.avatarUrl = vo.avatarUrl
        self.followers = vo.followers
        self.following = vo.following
        self.bio = vo.bio
    }
}

//
//  UserDTO.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation

// 작성자: nayoung kwon

struct UserDTO: Decodable {
    let id: Int
    let userName: String
    let avatarUrl: String
    let follower: Int
    let following: Int
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id, following, bio
        case userName = "login"
        case avatarUrl = "avatar_url"
        case follower = "followers"
    }
}

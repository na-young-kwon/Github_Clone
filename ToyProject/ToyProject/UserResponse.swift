//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation

struct UserResponse: Decodable, Hashable {
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

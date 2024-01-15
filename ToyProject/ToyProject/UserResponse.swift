//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

struct UserResponse: Codable, Hashable {
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

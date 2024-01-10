//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
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


//struct RepositoryResponse: Codable, Hashable, Identifiable {
//    var id: Int?
//    var fullName: String?
//    var htmlUrl: String?
//    let stargazersCount: Int
//    var watchersCount: Int
//    var language: String?
//    var forksCount: Int
//    
//    enum CodingKeys: String, CodingKey {
////        case id
//        case fullName = "full_name"
//        case htmlUrl = "html_url"
//        case stargazersCount = "stargazers_count"
//        case watchersCount = "watchers_count"
//        case language
//        case forksCount = "forks_count"
//        case follower = "followers"
//    }
//}

//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation

//struct UserResponse: Codable, Hashable, Identifiable {
//    let id: Int
//    var bio: String?
//    var followers: Int?
//    var following: Int?
//    var avatarUrl: String?
//    
//    var fullName: String?
//    var stargazersCount: Int?
//    var watchersCount: Int?
//    var language: String?
//    var forksCount: Int?
//    
//    var login: String?
//    var htmlUrl: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fullName = "full_name"
//        case stargazersCount = "stargazers_count"
//        case watchersCount = "watchers_count"
//        case language
//        case forksCount = "forks_count"
//        case htmlUrl = "html_url"
//        case avatarUrl = "avatar_url"
//        case login
//        case bio
//        case followers
//        case following
//    }
//}

struct UserResponse: Codable, Hashable, Identifiable {
    var id: Int = 0
    var login: String = ""
    var avatarUrl: String?
    var bio: String = ""
    var followers: Int = 0
    var following: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case bio
        case followers
        case following
    }
    
}


struct RepositoryResponse: Codable, Hashable, Identifiable {
    var id: Int?
    var fullName: String?
    var htmlUrl: String?
    let stargazersCount: Int
    var watchersCount: Int
    var language: String?
    var forksCount: Int
    
    enum CodingKeys: String, CodingKey {
//        case id
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
    }
}

//struct Owner: Codable, Hashable, Identifiable {
//    var login: String = ""
//    var id: Int = 0
//}


/*
 {
     "id": 138302237,
     "login": "Woobios97",
     "avatar_url": "https://avatars.githubusercontent.com/u/138302237?v=4",
     "bio": "iOS Developer 💻",
     "followers": 2,
     "following": 2,
 
     "type": "User",
 }
 
 "created_at": "2023-07-01T12:19:12Z",
 "updated_at": "2023-12-21T06:06:43Z"
 */

/*
 "created_at": "2023-12-12T15:10:36Z",
 "updated_at": "2023-12-12T15:11:15Z",
 "pushed_at": "2023-12-12T17:22:46Z",
 */

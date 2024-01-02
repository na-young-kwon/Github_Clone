//
//  UserResponse.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import Foundation

struct UserResponse: Codable, Hashable, Identifiable {
    let id: Int
    var fullName: String?
    var stargazersCount: Int?
    var watchersCount: Int?
    var language: String?
    var forksCount: Int?
    var htmlUrl: String?
    var avatarUrl: String?
    var login: String?
    var bio: String?
    var followers: Int?
    var following: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
        case avatarUrl = "avatar_url"
        case login
        case bio
        case followers
        case following
    }
}

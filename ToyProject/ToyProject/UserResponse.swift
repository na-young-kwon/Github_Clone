//
//  UserResponse.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation

/*
 {
    "full_name": "Woobios97/CompositionalLayout",
    "html_url": "https://github.com/Woobios97/CompositionalLayout",
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "Swift",
    "forks_count": 0,
}
 */

struct UserResponse: Codable {
    var user: [User]
}

struct User: Codable, Hashable {
    var fullName: String
    var stargazersCount: Int
    var watchersCount: Int
    var language: String
    var forksCount: Int
    var htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language = "language"
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
    }
}

extension User: Identifiable {
    var id: UUID { return UUID() }
}

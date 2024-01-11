//
//  RepositoryResponse.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation

struct RepositoryResponse: Decodable, Hashable {
    let id: Int
    let user: User
    let fullName: String
    let htmlUrl: String
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id, language
        case user = "owner"
        case starsCount = "stargazers_count"
        case watchersCount = "watchers"
        case forksCount = "forks_count"
        case fullName = "full_name"
        case htmlUrl = "html_url"
    }
    
    struct User: Decodable, Hashable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "login"
        }
    }
}

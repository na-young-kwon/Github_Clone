//
//  Repository.swift
//  ToyProject
//
//  Created by woosub kim  on 1/16/24.
//

import Foundation

struct RepositoryVO: Hashable, Identifiable {
    let id: Int
    let user: User
    let fullName: String
    let htmlUrl: String
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let language: String?
    
    struct User: Hashable {
        let name: String
    }
}

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

extension RepositoryVO {
    init(dto: RepositoryDTO) {
        self.id = dto.id
        self.user = User(name: dto.user.name)
        self.fullName = dto.fullName
        self.htmlUrl = dto.htmlUrl
        self.starsCount = dto.starsCount
        self.watchersCount = dto.watchersCount
        self.forksCount = dto.forksCount
        self.language = dto.language
    }
}

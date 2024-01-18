//
//  RepositoryResponse.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import Foundation

struct RepositoryDTO: Decodable, Hashable {
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

extension RepositoryDTO {
    static func toVO(dto: RepositoryDTO) -> RepositoryVO {
        return RepositoryVO(
            id: dto.id,
            user: RepositoryVO.User(name: dto.user.name),
            fullName: dto.fullName,
            htmlUrl: dto.htmlUrl,
            starsCount: dto.starsCount,
            watchersCount: dto.watchersCount,
            forksCount: dto.forksCount,
            language: dto.language
        )
    }
}

extension RepositoryDTO {
    init(vo: RepositoryVO) {
        self.id = vo.id
        self.user = User(name: vo.user.name)
        self.fullName = vo.fullName
        self.htmlUrl = vo.htmlUrl
        self.starsCount = vo.starsCount
        self.watchersCount = vo.watchersCount
        self.forksCount = vo.forksCount
        self.language = vo.language
    }
}

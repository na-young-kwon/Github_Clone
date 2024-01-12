//
//  RepositoryVo.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/12/24.
//

import Foundation

struct RepositoryVo: Hashable {
    let id: Int
    let userName: String
    let fullName: String
    let htmlUrl: String
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let language: String?
}

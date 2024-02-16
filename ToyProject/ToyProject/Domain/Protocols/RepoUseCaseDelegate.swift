//
//  RepoUseCaseDelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol RepoUseCaseDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO])
    func readRepository(_ userID: Int) -> [RepositoryVO]
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO]
    func deletRepository(_ userID: Int)
}

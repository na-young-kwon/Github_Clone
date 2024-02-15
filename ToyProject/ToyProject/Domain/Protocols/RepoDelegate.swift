//
//  RepoDelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol RepoDelegate {
    func saveRepository(_ repositoriesVO: [RepositoryVO])
    func readRepository(_ userID: Int) -> [RepositoryVO]
    func fetchRepository(_ userName: String) async throws -> [RepositoryVO]
    func deleteRepository(_ userID: Int)
}

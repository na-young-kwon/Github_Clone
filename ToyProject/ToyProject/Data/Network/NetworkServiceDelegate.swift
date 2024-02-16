//
//  NetworkServiceDelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol NetworkServiceDelegate {
    func fetchUser(forUser username: String) async throws -> UserDTO
    func fetchRepositories(forUser username: String) async throws -> [RepositoryDTO]
}

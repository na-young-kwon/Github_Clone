//
//  RepositoryDAODelegate.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation

protocol RepositoryDAODelegate {
    func create(_ repositoriesVO: [RepositoryVO])
    func read(_ userID: Int) -> [RepositoryVO]
    func delete(_ userID: Int)
}

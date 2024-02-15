//
//  DataContainer.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation
import Factory

extension Container {
    var userDAO: Factory<UserDAODelegate> {
        self { UserDAO() }.singleton
    }
    
    var repositoryDAO: Factory<RepositoryDAODelegate> {
        self { RepositoryDAO() }.singleton
    }

    var networkService: Factory<NetworkServiceDelegate> {
        self { NetworkService() }.singleton
    }
}

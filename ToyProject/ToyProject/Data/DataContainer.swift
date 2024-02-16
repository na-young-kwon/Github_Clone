//
//  DataContainer.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation
import Factory
import RealmSwift

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
    
    var userRealm: Factory<Realm> {
        self { Realm.open(configuration: Realm.userConfiguration) }.singleton
    }
    
    var repositoryRealm: Factory<Realm> {
        self { Realm.open(configuration: Realm.repositoryConfiguration) }.singleton
    }
}

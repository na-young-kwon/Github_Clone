//
//  DomainContainer.swift
//  ToyProject
//
//  Created by nayoung kwon on 2/15/24.
//

import Foundation
import Factory

extension Container {
    var userUseCase: Factory<UserUseCaseDelegate> {
        self { UserUseCase() }
    }
    
    var repoUseCase: Factory<RepoUseCaseDelegate> {
        self { RepoUseCase() }
    }
    
    var userRepository: Factory<UserDelegate> {
        self { UserRepository() }
    }
    
    var repoRepository: Factory<RepoDelegate> {
        self { RepoRepository() }
    }
}
//
//  SearchViewModel.swift
//  ToyProject
//
//  Created by woosub kim  on 1/18/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users: [UserVO] = []
    @Published var repositories: [RepositoryVO] = []
    
    private let userUseCase = UserUseCase()
    private let repoUseCase = RepoUseCase()
    
    func readAllUser() -> [UserVO] {
        users = userUseCase.readAllUser()
        return users
    }

    func deleteUser(_ userName: String) {
        userUseCase.deleteUser(userName)
    }
    
    func deleteRepositories(_ userName: String) {
        repoUseCase.deletRepository(userName)
    }
    
    func deleteUserAndRepositories(at offsets: IndexSet) {
        offsets.forEach { index in
            let userNameToDelete = users[index].userName
            deleteUser(userNameToDelete)
            deleteRepositories(userNameToDelete)
        }
//        readAllUser() 왜? unused
    }
}


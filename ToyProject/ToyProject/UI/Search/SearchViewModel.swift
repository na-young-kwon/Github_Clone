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
    
    func readAllUser() {
        users = userUseCase.readAllUser()
    }

    func deleteUser(_ userName: String) {
        userUseCase.deleteUser(userName)
    }
    
    func deleteRepositories(_ userID: Int) {
        repoUseCase.deletRepository(userID)
    }
    
    func deleteUserAndRepositories(at offsets: IndexSet) {
        offsets.forEach { index in
            let userToDelete = users[index].userName
            let repositoryDelete = users[index].id
            deleteUser(userToDelete)
            deleteRepositories(repositoryDelete)
        }
    }
}


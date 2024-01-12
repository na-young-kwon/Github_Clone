//
//  SearchViewModel.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users: [UserResponse] = []
    @Published var repositories: [RepositoryResponse] = []
    
    private let userUseCase = UserUseCase()
    private let repoUseCase = RepoUseCase()
    
    /// 모든 User  fetch
    func fetchUsers() {
        users = userUseCase.fetchUsers()
    }
    
    /// 모든 Repositories fetch
    func fetchRepositories() {
        repositories = repoUseCase.fetchRepositories()
    }
    
    /// 특정 User 삭제
    func deleteUser(_ userName: String) {
        userUseCase.deleteUser(userName)
    }
    
    /// 특정 Repositories 삭제
    func deleteRepositories(_ userName: String) {
        repoUseCase.deletRepository(userName)
    }
    
    /// 특정 user 와 repositories 삭제
    func deleteUserAndRepositories(at offsets: IndexSet) {
        offsets.forEach { index in
            let userNameToDelete = users[index].userName
            deleteUser(userNameToDelete)
            deleteRepositories(userNameToDelete)
        }
        fetchUsers()
        fetchRepositories()
    }
}

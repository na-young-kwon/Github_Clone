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
    
    /// 모든 user  fetch
    func fetchUsers() {
        users = UserRealmManager.shared.readAll()
    }
    
    /// 모든 repositories fetch
    func fetchRepositories() {
        repositories = RepositoryRealmManager.shared.readAll()
    }
    
    /// 특정 user 와 repositories 삭제
    func deleteUserAndRepositories(at offsets: IndexSet) {
        offsets.forEach { index in
            let userNameToDelete = users[index].userName
            UserRealmManager.shared.delete(userNameToDelete)
            RepositoryRealmManager.shared.delete(userNameToDelete)
        }
        fetchUsers()
        fetchRepositories()
    }
}

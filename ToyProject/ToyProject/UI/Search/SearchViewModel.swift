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
    
    ///  Created by 김우섭
    /// 모든 User  fetch
    func fetchUsers() {
        users = userUseCase.fetchUsers()
    }
    
    ///  Created by 김우섭
    /// 모든 Repositories fetch
    func fetchRepositories() {
        repositories = repoUseCase.fetchRepositories()
    }
    
    ///  Created by 김우섭
    /// 특정 User 삭제
    func deleteUser(_ userName: String) {
        userUseCase.deleteUser(userName)
    }
    
    ///  Created by 김우섭
    /// 특정 Repositories 삭제
    func deleteRepositories(_ userName: String) {
        repoUseCase.deletRepository(userName)
    }
    
    ///  Created by 김우섭
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


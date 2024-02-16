//
//  MockUserUseCase.swift
//  ToyProjectTests
//
//  Created by nayoung kwon on 2/16/24.
//

import Foundation

struct MockUserUseCase: UserUseCaseDelegate {
    func fetchUser(_ userName: String) async throws -> UserVO? {
        <#code#>
    }
    
    func saveUser(_ userVO: UserVO) {
        <#code#>
    }
    
    func readUser(_ userName: String) -> UserVO? {
        <#code#>
    }
    
    func readAllUser() -> [UserVO] {
        <#code#>
    }
    
    func deleteUser(_ userName: String) {
        <#code#>
    }
}

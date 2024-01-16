//
//  UserRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/12/24.
//

import Foundation

struct UserRepository {
    let networkService = NetworkService()
    
    func getAllUsers() -> [UserVo] {
        let users = UserRealmManager.shared.getAllUsers()
        
        let userVo = users.map { UserVo(id: $0.id,
                                         userName: $0.userName,
                                         avatarUrl: $0.avatarUrl,
                                         follower: $0.follower,
                                         following: $0.following,
                                         bio: $0.bio
        )}
        return userVo
    }
    
    // DB에서 유저 데이터 가져오는 메서드
    func getUser(by name: String) -> UserVo? {
        guard let user = UserRealmManager.shared.getUser(by: name) else {
            return nil
        }
        let userVo = UserVo(id: user.id,
                            userName: user.userName,
                            avatarUrl: user.avatarUrl,
                            follower: user.follower,
                            following: user.following,
                            bio: user.bio
        )
        return userVo
    }
    
    // API통신을 통해 유저 데이터 가져오는 메서드
    func fetchUser(by name: String) async throws -> UserVo {
        let user = try await networkService.fetchUser(forUser: name)
        UserRealmManager.shared.create(user)
        
        let userVo = UserVo(id: user.id,
                            userName: user.userName,
                            avatarUrl: user.avatarUrl,
                            follower: user.follower,
                            following: user.following,
                            bio: user.bio
        )
        return userVo
    }
    
    func deleteUser(_ user: UserVo) {
        UserRealmManager.shared.delete(user)
    }
}

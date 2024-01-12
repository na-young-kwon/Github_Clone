//
//  SearchRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchRepository {
    func fetchSearchHistory() -> [UserVo] {
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
    
    func deleteSearchText(_ user: UserVo) {
        UserRealmManager.shared.delete(user)
    }
}

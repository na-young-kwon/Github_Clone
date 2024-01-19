//
//  UserRepository.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/12/24.
//

import Foundation

struct UserRepository {
    private let networkService = NetworkService()
    private let userDao: UserDao = UserDao()
    private let repoDao: RepositoryDao = RepositoryDao()
    
    func getAllUser() -> [UserVo] {
        let users = userDao.getAllUser()
        
        let userVo = users.map { UserVo(id: $0.id,
                                         userName: $0.userName,
                                         avatarUrl: $0.avatarUrl,
                                         follower: $0.follower,
                                         following: $0.following,
                                         bio: $0.biography
        )}
        return userVo
    }
    
    // DB에서 유저 데이터 가져오는 메서드
    func getUser(by name: String) -> UserVo? {
        guard let user = userDao.getUser(by: name) else {
            return nil
        }
        let userVo = UserVo(id: user.id,
                            userName: user.userName,
                            avatarUrl: user.avatarUrl,
                            follower: user.follower,
                            following: user.following,
                            bio: user.biography
        )
        return userVo
    }
    
    // API통신을 통해 유저 데이터 가져오는 메서드
    func fetchUser(by name: String) async throws -> UserVo {
        let userDTO = try await networkService.fetchUser(forUser: name)
        
        let userVo = UserVo(id: userDTO.id,
                            userName: userDTO.userName,
                            avatarUrl: userDTO.avatarUrl,
                            follower: userDTO.follower,
                            following: userDTO.following,
                            bio: userDTO.bio
        )
        try userDao.create(userVo)
        return userVo
    }
    
    func deleteUser(_ user: UserVo) {
        userDao.delete(id: user.id)
        repoDao.delete(userName: user.userName)
    }
}

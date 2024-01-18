//
//  UserRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

/// created by 김우섭
class UserRealmManager {
    static let shared = UserRealmManager()
    private let realm = try! Realm()
    
    private init() {}
    
    /// Realm에 유저 Create & Update
    func create(_ userDTO: UserDTO) {
        do {
            try realm.write {
                if let existingUser = realm.objects(UserForRealm.self).filter("userName =[c] %@", userDTO.userName).first {
                    // 기존 객체가 있으면 정보 업데이트
//                    existingUser.id = userDTO.id
                    existingUser.avatarUrl = userDTO.avatarUrl
                    existingUser.follower = userDTO.followers
                    existingUser.following = userDTO.following
                    existingUser.bio = userDTO.bio ?? ""
                } else {
                    // 없으면 새 객체 생성
                    let newUser = UserForRealm(
                        id: userDTO.id,
                        userName: userDTO.userName,
                        avatarUrl: userDTO.avatarUrl,
                        follower: userDTO.followers,
                        following: userDTO.following,
                        bio: userDTO.bio ?? ""
                    )
                    realm.add(newUser, update: .modified)
                }
            }
        } catch {
            print("유저 정보를 업데이트하는 데 실패했습니다 - \(error)")
        }
    }

    /// Realm에 특정 유저 Read
    func read(_ userName: String) -> UserDTO? {
        let userResponseForRealm = realm.objects(UserForRealm.self).filter("userName =[c] %@", userName).first
        guard let userResponseForRealm = userResponseForRealm else { return nil }
        let userDTO = UserDTO(
            id: userResponseForRealm.id,
            userName: userResponseForRealm.userName,
            avatarUrl: userResponseForRealm.avatarUrl,
            followers: userResponseForRealm.follower,
            following: userResponseForRealm.following,
            bio: userResponseForRealm.bio
        )
        return userDTO
    }
    
    /// Realm에 모든 유저 Read
    func readAll() -> [UserDTO] {
        let users = realm.objects(UserForRealm.self)
        return users.map { UserDTO(
            id: $0.id,
            userName: $0.userName,
            avatarUrl: $0.avatarUrl,
            followers: $0.follower,
            following: $0.following,
            bio: $0.bio)
        }
    }
    
    /// Realm에 특정 유저 Delete
    func delete(_ userName: String) {
        do {
            let userToDelete = realm.objects(UserForRealm.self).filter("userName =[c] %@", userName)
            try realm.write {
                realm.delete(userToDelete)
            }
        } catch {
            print("유저를 삭제하는 실패 - \(userName)")
        }
    }
}

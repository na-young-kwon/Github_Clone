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
    
    /// Realm에 유저 Create
    func create(_ userResponse: UserDTO) {
        do {
            try realm.write {
                let user = UserForRealm(
                    id: userResponse.id,
                    userName: userResponse.userName,
                    avatarUrl: userResponse.avatarUrl,
                    follower: userResponse.followers,
                    following: userResponse.following,
                    bio: userResponse.bio ?? ""
                )
                realm.add(user, update: .modified)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
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

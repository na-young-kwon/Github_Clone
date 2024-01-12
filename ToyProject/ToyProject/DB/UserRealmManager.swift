//
//  UserRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation
import RealmSwift

class UserRealmManager {
    static let shared = UserRealmManager()
    private let realm = try! Realm()
    
    private init() {}
    
    /// Create
    func create(_ userResponse: UserResponse) {
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
                realm.add(user)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    /// Read
    func read(_ userName: String) -> [UserResponse] {
        let userResponseForRealm = realm.objects(UserForRealm.self).filter("userName =[c] %@", userName)
        
        return userResponseForRealm.map { realmObject in
            UserResponse(
                id: realmObject.id,
                userName: realmObject.userName,
                avatarUrl: realmObject.avatarUrl,
                followers: realmObject.follower,
                following: realmObject.following,
                bio: realmObject.bio
            )
        }
    }
    
    /// 모든 유저 Read
    func readAll() -> [UserResponse] {
        let users = realm.objects(UserForRealm.self)
        return users.map { UserResponse(
            id: $0.id,
            userName: $0.userName,
            avatarUrl: $0.avatarUrl,
            followers: $0.follower,
            following: $0.following,
            bio: $0.bio)
        }
    }
    
    /// Delete
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

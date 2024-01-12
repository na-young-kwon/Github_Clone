//
//  UserRealmManager.swift
//  ToyProject
//
//  Created by nayoung kwon  on 1/10/24.
//

import Foundation
import RealmSwift

// 작성자: nayoung kwon

class UserRealmManager {
    static let shared = UserRealmManager()
    private let realm = try! Realm()
    
    private init() {}
    
    // create
    func create(_ user: UserResponse) {
        do {
            try realm.write {
                let user = UserForRealm(
                    id: user.id,
                    userName: user.userName,
                    avatarUrl: user.avatarUrl,
                    follower: user.follower,
                    following: user.following,
                    bio: user.bio ?? "",
                    createdAt: Date()
                )
                realm.add(user)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read - 특정 유저 반환
    func getUser(by userName: String) -> UserResponse? {
        guard let user = realm.objects(UserForRealm.self).filter("userName == [c] %@", userName).first else {
            return nil
        }
        updateCreatedTime(user: user)
        
        let userResponse = UserResponse(
            id: user.id,
            userName: user.userName,
            avatarUrl: user.avatarUrl,
            follower: user.follower,
            following: user.following,
            bio: user.bio
        )
        return userResponse
    }
    
    // read - 모든 유저 반환
    func getAllUsers() -> [UserResponse] {
        let sortedUsers = realm.objects(UserForRealm.self).sorted(byKeyPath: "createdAt", ascending: true)
        let userResponse = sortedUsers.map {
            UserResponse(
                id: $0.id,
                userName: $0.userName,
                avatarUrl: $0.avatarUrl,
                follower: $0.follower,
                following: $0.following,
                bio: $0.bio
            )
        }
        return Array(userResponse)
    }
    
    // update
    private func updateCreatedTime(user: UserForRealm) {
        do {
            try realm.write {
                user.createdAt = Date()
            }
        } catch {
            print("유저 정보 업데이트를 실패했습니다 - \(error)")
        }
    }
    
    // delete
    func delete(_ user: UserResponse) {
        do {
            let task = realm.objects(UserForRealm.self).where { $0.id == user.id }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("유저를 삭제하는 데 실패했습니다 - \(error)")
        }
    }
}

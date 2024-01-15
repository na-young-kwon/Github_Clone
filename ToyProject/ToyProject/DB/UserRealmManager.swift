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
    
    var realm: Realm {
        return Realm.open(configuration: Realm.userConfiguration)
    }
    
    private init() {}
    
    // create
    func create(_ user: UserDTO) {
        do {
            try realm.write {
                let user = User(id: user.id,
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
    func getUser(by userName: String) -> User? {
        guard let user = realm.objects(User.self).filter("userName == [c] %@", userName).first else {
            return nil
        }
        updateCreatedTime(user: user)
        return user
    }
    
    // read - 모든 유저 반환
    func getAllUsers() -> [User] {
        let users = realm.objects(User.self).sorted(byKeyPath: "createdAt", ascending: true)
        return Array(users)
    }
    
    // update
    private func updateCreatedTime(user: User) {
        do {
            try realm.write {
                user.createdAt = Date()
            }
        } catch {
            print("유저 정보 업데이트를 실패했습니다 - \(error)")
        }
    }
    
    // delete
    func delete(_ user: UserVo) {
        do {
            let task = realm.objects(User.self).where { $0.id == user.id }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("유저를 삭제하는데 실패했습니다 - \(error)")
        }
    }
}

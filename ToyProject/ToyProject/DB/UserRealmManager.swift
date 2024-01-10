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
    
    // create
    func create(_ userResponse: UserResponse) {
        do {
            try realm.write {
                let user = UserForRealm(
                    id: userResponse.id,
                    userName: userResponse.userName,
                    avatarUrl: userResponse.avatarUrl,
                    follower: userResponse.follower,
                    following: userResponse.following,
                    bio: userResponse.bio ?? ""
                )
                realm.add(user)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read
    func read() -> [UserResponse] {
        let userResponseForRealm = realm.objects(UserForRealm.self)
        
        let users = userResponseForRealm.map {
            UserResponse(
                id: $0.id,
                userName: $0.userName,
                avatarUrl: $0.avatarUrl,
                follower: $0.follower,
                following: $0.following,
                bio: $0.bio
            )
        }
        return Array(users)
    }
    
    // delete
    func delete(_ userResponse: UserResponse) {
        do {
            let task = realm.objects(UserForRealm.self)
                .where { $0.id == userResponse.id }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("유저를 삭제하는 데 실패했습니다 - \(error)")
        }
    }
}

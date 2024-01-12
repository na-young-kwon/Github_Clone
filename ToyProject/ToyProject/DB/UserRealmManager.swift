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
    
    // read
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

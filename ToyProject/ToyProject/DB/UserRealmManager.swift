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
        let realm = try! Realm()
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
    func getUser(by userName: String) -> UserResponse? {
//        let realm = try! Realm()
        guard let user = realm.objects(UserForRealm.self).filter("userName == [c] %@", userName).first else {
            return nil
        }
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
    
    // delete
//    func delete(_ userResponse: UserResponse) {
//        let realm = try! Realm()
//        do {
//            let task = realm.objects(UserForRealm.self)
//                .where { $0.id == userResponse.id }
//            try realm.write {
//                realm.delete(task)
//            }
//        } catch {
//            print("유저를 삭제하는 데 실패했습니다 - \(error)")
//        }
//    }
}

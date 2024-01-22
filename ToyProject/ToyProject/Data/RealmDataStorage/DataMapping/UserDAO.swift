//
//  UserRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

class UserDAO {
    static let shared = UserDAO()
    private let realm = try! Realm()
    
    private init() {}
    
    func create(_ userVO: UserVO) {
        do {
            try realm.write {
                let userVO = UserForRealm(
                    id: userVO.id,
                    userName: userVO.userName,
                    avatarUrl: userVO.avatarUrl,
                    follower: userVO.followers,
                    following: userVO.following,
                    biography: userVO.bio
                )
                realm.add(userVO, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    /// 전체 유저 Read
    func readAll() -> [UserVO] {
        let userForRealm = realm.objects(UserForRealm.self)
        return userForRealm.map {
            UserVO(
                id: $0.id,
                userName: $0.userName,
                avatarUrl: $0.avatarUrl,
                followers: $0.follower,
                following: $0.following,
                bio: $0.biography ?? "N/A"
            )
        }
    }
    
    /// 특정 유적 Read
    func read(_ userName: String) -> UserVO? {
        let userForRealm = realm.objects(UserForRealm.self).filter("userName =[c] %@", userName).first
        guard let userForRealm = userForRealm else { return nil }
        return UserVO(
            id: userForRealm.id,
            userName: userForRealm.userName,
            avatarUrl: userForRealm.avatarUrl,
            followers: userForRealm.follower,
            following: userForRealm.following,
            bio: userForRealm.biography ?? "N/A"
        )
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

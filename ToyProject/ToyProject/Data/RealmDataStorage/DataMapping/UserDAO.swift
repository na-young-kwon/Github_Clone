//
//  UserRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

/// created by 김우섭
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
                    bio: userVO.bio
                )
                realm.add(userVO, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func readAll() -> [UserVO] {
        let userForRealm = realm.objects(UserForRealm.self)
        return userForRealm.map {
            UserVO(
                id: $0.id,
                userName: $0.userName,
                avatarUrl: $0.avatarUrl,
                followers: $0.follower,
                following: $0.following,
                bio: $0.bio
            )
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

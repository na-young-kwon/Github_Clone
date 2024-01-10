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
                let user = UserForRealm(id: userResponse.id, avatarUrl: userResponse.avatarUrl ?? "", userName: userResponse.login, bio: userResponse.bio, follower: userResponse.followers, following: userResponse.following)
                realm.add(user)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read
    func read() -> [UserResponse] {
        var userResponse = [UserResponse]()
        let userResponseForRealm = realm.objects(UserForRealm.self)
        
        for user in userResponseForRealm {
            userResponse.append(UserResponse(id: user.id, login: user.userName, avatarUrl: user.avatarUrl, bio: user.bio, followers: user.follower, following: user.following))
        }
        return userResponse
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

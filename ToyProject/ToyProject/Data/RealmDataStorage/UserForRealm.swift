//
//  UserForRealm.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation
import RealmSwift

// version : 0
//class UserForRealm: Object {
//    @Persisted(primaryKey: true) var id: Int
//    @Persisted var userName: String = ""
//    @Persisted var avatarUrl: String = ""
//    @Persisted var follower: Int = 0
//    @Persisted var following: Int = 0
//    @Persisted var bio: String = ""
//    
//    convenience init(id: Int, userName: String, avatarUrl: String, follower: Int, following: Int, bio: String) {
//        self.init()
//        self.id = id
//        self.avatarUrl = avatarUrl
//        self.userName = userName
//        self.bio = bio
//        self.follower = follower
//        self.following = following
//    }
//
//}

// version : 1
class UserForRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userName: String = ""
    @Persisted var avatarUrl: String = ""
    @Persisted var follower: Int = 0
    @Persisted var following: Int = 0
    @Persisted var biography: String? = ""
    
    convenience init(id: Int, userName: String, avatarUrl: String, follower: Int, following: Int, biography: String?) {
        self.init()
        self.id = id
        self.avatarUrl = avatarUrl
        self.userName = userName
        self.follower = follower
        self.following = following
        self.biography = biography
    }

}
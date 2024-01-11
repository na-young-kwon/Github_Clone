//
//  UserForRealm.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation
import RealmSwift

class UserForRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userName: String = ""
    @Persisted var avatarUrl: String = ""
    @Persisted var follower: Int = 0
    @Persisted var following: Int = 0
    @Persisted var bio: String = ""
    @Persisted var createdAt: Date
    
    convenience init(id: Int, userName: String, avatarUrl: String, follower: Int, following: Int, bio: String, createdAt: Date = Date()) {
        self.init()
        self.id = id
        self.userName = userName
        self.avatarUrl = avatarUrl
        self.follower = follower
        self.following = following
        self.bio = bio
        self.createdAt = createdAt
    }
}

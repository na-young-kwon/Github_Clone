//
//  User.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation
import RealmSwift

// 작성자: nayoung kwon

class User: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userName: String = ""
    @Persisted var avatarUrl: String = ""
    @Persisted var follower: Int = 0
    @Persisted var following: Int = 0
    @Persisted var bio: String = ""
    @Persisted var createdAt: Date = Date()
    
    convenience init(id: Int, userName: String, avatarUrl: String, follower: Int, following: Int, bio: String, createdAt: Date) {
        self.init()
        self.id = id
        self.userName = userName
        self.avatarUrl = avatarUrl
        self.follower = follower
        self.following = following
        self.bio = bio
        self.createdAt = createdAt
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let user = object as? User {
            return self.id == user.id
            && self.avatarUrl == user.avatarUrl
            && self.follower == user.follower
            && self.following == user.following
            && self.bio == user.bio
        } else {
            return false
        }
    }
}

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
    @Persisted var biography: String? = nil
    @Persisted var createdAt: Date = Date()
    
    convenience init(id: Int, userName: String, avatarUrl: String, follower: Int, following: Int, biography: String?, createdAt: Date) {
        self.init()
        self.id = id
        self.userName = userName
        self.avatarUrl = avatarUrl
        self.follower = follower
        self.following = following
        self.biography = biography
        self.createdAt = createdAt
    }
}

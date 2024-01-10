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
    @Persisted var avatarUrl: String = ""
    @Persisted var userName: String = ""
    @Persisted var bio: String? = nil
    @Persisted var follower: Int = 0
    @Persisted var following: Int = 0
}

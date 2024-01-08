//
//  SearchHistoryForRealm.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/28/23.
//

import Foundation
import RealmSwift

class SearchHistoryForRealm: Object {
    @Persisted(primaryKey: true) var userID: Int
    @Persisted var userName: String
    @Persisted var createdAt: Date = Date()
    @Persisted var age: Int
    @Persisted var isNew: Bool = false
    @Persisted var nickName: String = ""
    
    convenience init(id: Int, userName: String) {
        self.init()
        self.userID = id
        self.userName = userName
    }
}

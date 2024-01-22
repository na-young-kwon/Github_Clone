//
//  RepositoryForRealm.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation
import RealmSwift

class RepositoryForRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userName: String = ""
    @Persisted var htmlUrl: String = ""
    @Persisted var fullName: String = ""
    @Persisted var starsCount: Int = 0
    @Persisted var watchersCount: Int = 0
    @Persisted var forksCount: Int = 0
    @Persisted var language: String? = nil
    
    convenience init(id: Int, htmlUrl: String, userName: String , fullName: String, starsCount: Int, watchersCount: Int, forksCount: Int, language: String? = nil) {
        self.init()
        self.id = id
        self.userName = userName
        self.htmlUrl = htmlUrl
        self.fullName = fullName
        self.starsCount = starsCount
        self.watchersCount = watchersCount
        self.forksCount = forksCount
        self.language = language
    }

}

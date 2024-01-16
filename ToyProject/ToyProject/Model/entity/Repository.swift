//
//  Repository.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/10/24.
//

import Foundation
import RealmSwift

// 작성자: nayoung kwon

class Repository: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userName: String = ""
    @Persisted var htmlUrl: String = ""
    @Persisted var fullName: String = ""
    @Persisted var starsCount: Int = 0
    @Persisted var watchersCount: Int = 0
    @Persisted var forksCount: Int = 0
    @Persisted var language: String? = nil
    
    convenience init(id: Int, userName: String, htmlUrl: String, fullName: String, starsCount: Int, watchersCount: Int, forksCount: Int, language: String?) {
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
    
    override func isEqual(_ object: Any?) -> Bool {
        if let repository = object as? Repository {
            return self.id == repository.id
            && self.htmlUrl == repository.htmlUrl
            && self.fullName == repository.fullName
            && self.starsCount == repository.starsCount
            && self.watchersCount == repository.watchersCount
            && self.forksCount == repository.forksCount
            && self.language == repository.language
        } else {
            return false
        }
    }
}

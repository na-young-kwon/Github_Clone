//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation
import RealmSwift

// 작성자: nayoung kwon

class RepositoryRealmManager {
    static let shared = RepositoryRealmManager()
//    private let realm = try! Realm()
    
    private init() {}
    
    // create
    func create(_ repositories: [RepositoryDTO]) {
        let realm = try! Realm()
        do {
            try realm.write {
                let repos = repositories.map { Repository(id: $0.id,
                                                          userName: $0.user.name,
                                                          htmlUrl: $0.htmlUrl,
                                                          fullName: $0.fullName,
                                                          starsCount: $0.starsCount,
                                                          watchersCount: $0.watchersCount,
                                                          forksCount: $0.forksCount,
                                                          language: $0.language
                )}
                realm.add(repos)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read
    func getRepository(by userName: String) -> [Repository]? {
        let realm = try! Realm()
        let repositories = realm.objects(Repository.self).filter("userName == [c] %@", userName)
        
        guard !repositories.isEmpty else {
            return nil
        }
        return Array(repositories)
    }
}

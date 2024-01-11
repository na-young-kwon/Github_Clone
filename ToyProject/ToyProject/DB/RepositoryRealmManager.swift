//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation
import RealmSwift

class RepositoryRealmManager {
    static let shared = RepositoryRealmManager()
//    private let realm = try! Realm()
    
    private init() {}
    
    // create
    func create(_ repositories: [RepositoryResponse]) {
        let realm = try! Realm()
        do {
            try realm.write {
                let repos = repositories.map {
                    RepositoryForRealm(
                        id: $0.id,
                        userName: $0.user.name,
                        htmlUrl: $0.htmlUrl,
                        fullName: $0.fullName,
                        starsCount: $0.starsCount,
                        watchersCount: $0.watchersCount,
                        forksCount: $0.forksCount,
                        language: $0.language
                    )
                }
                realm.add(repos)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read
    func getRepository(by userName: String) -> [RepositoryResponse]? {
        let realm = try! Realm()
        let repoFromRealm = realm.objects(RepositoryForRealm.self).filter("userName == [c] %@", userName)
        guard !repoFromRealm.isEmpty else {
            return nil
        }
        
        let repositories = repoFromRealm.map {
            RepositoryResponse(
                id: $0.id,
                user: RepositoryResponse.User(name: $0.userName),
                fullName: $0.fullName,
                htmlUrl: $0.htmlUrl,
                starsCount: $0.starsCount,
                watchersCount: $0.watchersCount,
                forksCount: $0.forksCount,
                language: $0.language
            )
        }
        return Array(repositories)
    }
    
    // delete
//    func delete(_ repository: RepositoryResponse) {
//        let realm = try! Realm()
//        do {
//            let task = realm.objects(RepositoryForRealm.self)
//                .where { $0.id == repository.id }
//            try realm.write {
//                realm.delete(task)
//            }
//        } catch {
//            print("유저를 삭제하는 데 실패했습니다 - \(error)")
//        }
//    }
}

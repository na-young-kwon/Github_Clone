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
    private let realm = try! Realm()
    
    private init() {}
    
    // create
    func create(_ repository: RepositoryResponse) {
        do {
            try realm.write {
                let repository = RepositoryForRealm(
                    id: repository.id,
                    htmlUrl: repository.htmlUrl,
                    userName: repository.user.name,
                    fullName: repository.fullName,
                    starsCount: repository.starsCount,
                    watchersCount: repository.watchersCount,
                    forksCount: repository.forksCount,
                    language: repository.language
                )
                realm.add(repository, update: .modified)
            }
        } catch {
            print("유저를 생성하는 데 실패했습니다 - \(error)")
        }
    }
    
    // read
    func read(_ userName: String) -> [RepositoryResponse] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self).filter("userName =[c] %@", userName)
        
        return repositoryForRealm.map { realmObject in
            RepositoryResponse(
                id: realmObject.id,
                user: RepositoryResponse.User(name: realmObject.userName),
                fullName: realmObject.fullName,
                htmlUrl: realmObject.htmlUrl,
                starsCount: realmObject.starsCount,
                watchersCount: realmObject.watchersCount,
                forksCount: realmObject.forksCount,
                language: realmObject.language
            )
        }
    }
    
    // delete
    func delete(_ repository: RepositoryResponse) {
        do {
            let task = realm.objects(RepositoryForRealm.self)
                .where { $0.id == repository.id }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("유저를 삭제하는 데 실패했습니다 - \(error)")
        }
    }
}

//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

/// created by 김우섭
class RepositoryRealmManager {
    static let shared = RepositoryRealmManager()
    private let realm = try! Realm()
    
    private init() {}
    
    /// Realm에 레포지토리 Create
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
    
    /// Realm에 특정 레포지토리 Read
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
    
    /// Realm에 모든 레포지토리 Read
    func readAll() -> [RepositoryResponse] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self)
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
    
    /// Realm에 특정 레포지토리 Read
    func delete(_ userName: String) {
        do {
            let repositoryToDelete = realm.objects(RepositoryForRealm.self).filter("userName =[c] %@", userName)
            try realm.write {
                realm.delete(repositoryToDelete)
            }
        } catch {
            print("레포지토리를 삭제하는 데 실패 - \(userName)")
        }
    }
}

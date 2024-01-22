//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

class RepositoryDAO {
    static let shared = RepositoryDAO()
    private let realm = try! Realm()
    
    private init() {}
    
    func create(_ repositoriesVO: [RepositoryVO]) {
        do {
            try realm.write {
                let repositoryForRealm = repositoriesVO.map { vo -> RepositoryForRealm in
                    return RepositoryForRealm(
                        id: vo.id,
                        htmlUrl: vo.htmlUrl,
                        userName: vo.user.name,
                        fullName: vo.fullName,
                        starsCount: vo.starsCount,
                        watchersCount: vo.watchersCount,
                        forksCount: vo.forksCount,
                        language: vo.language
                    )
                }
                realm.add(repositoryForRealm, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func read(_ userName: String) -> [RepositoryVO] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self).filter("userName =[c] %@", userName)
        return repositoryForRealm.map { realm -> RepositoryVO in
            RepositoryVO(
                id: realm.id,
                user: RepositoryVO.User(name: realm.userName),
                fullName: realm.fullName,
                htmlUrl: realm.htmlUrl,
                starsCount: realm.starsCount,
                watchersCount: realm.watchersCount,
                forksCount: realm.forksCount,
                language: realm.language
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

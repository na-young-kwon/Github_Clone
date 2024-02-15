//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

protocol RepositoryDAODelegate {
    func create(_ repositoriesVO: [RepositoryVO])
    func read(_ userID: Int) -> [RepositoryVO]
    func delete(_ userID: Int)
}

class RepositoryDAO: RepositoryDAODelegate {
    
    private let realm = try! Realm()
    
    func create(_ repositoriesVO: [RepositoryVO]) {
        do {
            try realm.write {
                let repositoryForRealm = repositoriesVO.map { vo -> RepositoryForRealm in
                    return RepositoryForRealm(
                        id: vo.id,
                        htmlUrl: vo.htmlUrl,
                        ownerID: vo.user.userID,
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
    
    func read(_ userID: Int) -> [RepositoryVO] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self).filter("ownerID == %d", userID)
        return repositoryForRealm.map { realm -> RepositoryVO in
            RepositoryVO(
                id: realm.id,
                user: RepositoryVO.User(userID: realm.ownerID),
                fullName: realm.fullName,
                htmlUrl: realm.htmlUrl,
                starsCount: realm.starsCount,
                watchersCount: realm.watchersCount,
                forksCount: realm.forksCount,
                language: realm.language
            )
        }
    }
    
    func delete(_ userID: Int) {
        do {
            let repositoryToDelete = realm.objects(RepositoryForRealm.self).filter("ownerID == %d", userID)
            try realm.write {
                realm.delete(repositoryToDelete)
            }
        } catch {
            print("레포지토리를 삭제하는 데 실패 - \(userID)")
        }
    }
    
}

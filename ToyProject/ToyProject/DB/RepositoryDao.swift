//
//  RepositoryDao.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/16/24.
//

import Foundation
import RealmSwift

struct RepositoryDao {
    
    private var realm: Realm {
        return Realm.open(configuration: Realm.repositoryConfiguration)
    }
    
    func create(_ repositories: [RepositoryDTO]) {
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
    
    func getRepository(by userName: String) -> [Repository] {
        let repositories = realm.objects(Repository.self).filter("userName == [c] %@", userName)

        if repositories.isEmpty {
            return []
        }
        return Array(repositories)
    }
    
    func delete(_ user: UserVo) {
        do {
            let task = realm.objects(Repository.self).where { $0.userName == user.userName }
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("레포지토리를 삭제하는데 실패했습니다 - \(error)")
        }
    }
}

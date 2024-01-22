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
    
    func getRepository(by ownerID: Int) -> [Repository] {
        let query = "ownerID == %@"
        let repositories = realm.objects(Repository.self).filter(query, ownerID)
        return Array(repositories)
    }
    
    func create(_ repositories: [RepositoryVo]) throws {
        do {
            try realm.write {
                let repos = repositories.map { Repository(id: $0.id,
                                                          ownerID: $0.ownerID,
                                                          htmlUrl: $0.htmlUrl,
                                                          fullName: $0.fullName,
                                                          starsCount: $0.starsCount,
                                                          watchersCount: $0.watchersCount,
                                                          forksCount: $0.forksCount,
                                                          language: $0.language
                )}
                realm.add(repos, update: .modified)
            }
        } catch {
            print("레포지토리를 저장하는 데 실패했습니다 - \(error)")
            throw RealmError.failToCreateRepository
        }
    }
    
    func delete(ownerID: Int) {
        do {
            let query = "ownerID == %@"
            let task = realm.objects(Repository.self).filter(query, ownerID)
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("레포지토리를 삭제하는데 실패했습니다 - \(error)")
        }
    }
    
    // 레포 개수가 줄었을 때 더 이상 존재하지 않는 레포지토리를 삭제하는 메서드
    func compareAndDelete(repos: [RepositoryVo]) {
        guard let ownerID = repos.first?.ownerID else {
            return
        }
        if repos.isEmpty {
            delete(ownerID: ownerID)
        } else {
            let repoFromRealm = getRepository(by: ownerID).map { $0.id }
            let repoFromAPI = repos.map { $0.id }
            let itemToDelete = Set(repoFromRealm).subtracting(Set(repoFromAPI))
            
            do {
                try realm.write {
                    let item = realm.objects(Repository.self).filter { itemToDelete.contains($0.id) }
                    realm.delete(item)
                }
            } catch {
                print("레포지토리를 삭제하는데 데 실패했습니다 - \(error)")
            }
        }
    }
}

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
    func create(_ repositoriesDTO: [RepositoryDTO]) {
        let repositoryForRealm = repositoriesDTO.map { dto -> RepositoryForRealm in
            return RepositoryForRealm(
                id: dto.id,
                htmlUrl: dto.htmlUrl,
                userName: dto.user.name,
                fullName: dto.fullName,
                starsCount: dto.starsCount,
                watchersCount: dto.starsCount,
                forksCount: dto.forksCount,
                language: dto.language
            )
        }
        do {
            try realm.write {
                for repository in repositoryForRealm {
                    realm.add(repository, update: .modified)
                }
            }
        } catch {
            print("레로지토리를 저장하는 데 실패했습니다. - \(repositoriesDTO)")
        }
        
    }
    
    /// Realm에 특정 레포지토리 Read
    func read(_ userName: String) -> [RepositoryDTO] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self).filter("userName =[c] %@", userName)
        return repositoryForRealm.map { realmObject in
            RepositoryDTO(
                id: realmObject.id,
                user: RepositoryDTO.User(name: realmObject.userName),
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
    func readAll() -> [RepositoryDTO] {
        let repositoryForRealm = realm.objects(RepositoryForRealm.self)
        return repositoryForRealm.map { realmObject in
            RepositoryDTO(
                id: realmObject.id,
                user: RepositoryDTO.User(name: realmObject.userName),
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
    
    var repositoryForRealm: RepositoryForRealm?
    
    func update() {
        if let repositoryForRealm = repositoryForRealm {
            do {
                guard let updateToRepo = realm.object(ofType: RepositoryForRealm.self, forPrimaryKey: repositoryForRealm.userName) else { return }
                try realm.write {
                    updateToRepo.id = repositoryForRealm.id
                    updateToRepo.userName = repositoryForRealm.userName
                    updateToRepo.htmlUrl = repositoryForRealm.htmlUrl
                    updateToRepo.fullName = repositoryForRealm.fullName
                    updateToRepo.starsCount = repositoryForRealm.starsCount
                    updateToRepo.forksCount = repositoryForRealm.forksCount
                    updateToRepo.language = repositoryForRealm.language
                }
            }
            catch {
                print(error)
            }
            
        }
    }
    
    
    
}

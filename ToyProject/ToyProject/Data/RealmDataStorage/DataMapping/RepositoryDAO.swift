//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/12/24.
//

import Foundation
import RealmSwift

/// created by 김우섭
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



/*
 
 
 /// Realm에 레포지토리 Create
 func create1(_ repositoriesDTO: [RepositoryDTO]) {
     do {
         try realm.write {
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
//                repositoryForRealm.forEach {
                 realm.add(repositoryForRealm, update: .modified)
//                }
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
 */

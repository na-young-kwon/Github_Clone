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
        do {
            try realm.write {
                for repositoryDTO in repositoriesDTO {
                    // id를 기준으로 기존 Repository 객체를 검색
                    if let existingRepository = realm.objects(RepositoryForRealm.self).filter("id = %d", repositoryDTO.id).first {
                        // 기존 객체가 존재하면, 정보 업데이트 (기본 키는 변경하지 않음)
                        existingRepository.htmlUrl = repositoryDTO.htmlUrl
                        existingRepository.userName = repositoryDTO.user.name
                        existingRepository.fullName = repositoryDTO.fullName
                        existingRepository.starsCount = repositoryDTO.starsCount
                        existingRepository.watchersCount = repositoryDTO.watchersCount
                        existingRepository.forksCount = repositoryDTO.forksCount
                        existingRepository.language = repositoryDTO.language
                    } else {
                        // 새로운 Repository 객체 생성 및 추가
                        let newRepository = RepositoryForRealm(
                            id: repositoryDTO.id,
                            htmlUrl: repositoryDTO.htmlUrl,
                            userName: repositoryDTO.user.name,
                            fullName: repositoryDTO.fullName,
                            starsCount: repositoryDTO.starsCount,
                            watchersCount: repositoryDTO.watchersCount,
                            forksCount: repositoryDTO.forksCount,
                            language: repositoryDTO.language
                        )
                        realm.add(newRepository, update: .modified)
                    }
                }
            }
        } catch {
            print("레포지토리를 저장하는 데 실패했습니다 - \(error)")
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
}

//
//  RepositoryRealmManager.swift
//  ToyProject
//
//  Created by woosub kim  on 1/10/24.
//

import Foundation
import RealmSwift

//class RepositoryRealmManager {
//    static let shared = RepositoryRealmManager()
//    private let realm = try! Realm()
//    
//    private init() {}
//    
//    // create
//    func create(_ repository: RepositoryResponse) {
//        do {
//            try realm.write {
//                let repository = RepositoryForRealm(id: repository.id, htmlUrl: repository.htmlUrl, fullName: repository.fullName, starsCount: repository.stargazersCount, watchersCount: repository.watchersCount, forksCount: repository.forksCount)
//                realm.add(repository)
//            }
//        } catch {
//            print("유저를 생성하는 데 실패했습니다 - \(error)")
//        }
//    }
//    
//    // read
//    func read() -> [RepositoryResponse] {
//        var repositoryResponse = [RepositoryResponse]()
//        let repositoryForRealm = realm.objects(RepositoryForRealm.self)
//        
//        for repository in repositoryForRealm {
//            repositoryResponse.append(RepositoryResponse(id: repository.id, fullName: repository.fullName, htmlUrl: repository.htmlUrl, watchersCount: repository.watchersCount, language: repository.language ?? "", forksCount: repository.forksCount))
//        }
//        
//        return repositoryResponse
//    }
//    
//    // delete
//    func delete(_ repository: RepositoryResponse) {
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
//}

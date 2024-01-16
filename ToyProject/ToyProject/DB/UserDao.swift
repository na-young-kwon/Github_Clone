//
//  UserDao.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/16/24.
//

import Foundation
import RealmSwift

struct UserDao {
    
    private var realm: Realm {
        return Realm.open(configuration: Realm.userConfiguration)
    }
    
    func getAllUser() -> [User] {
        let users = realm.objects(User.self).sorted(byKeyPath: "createdAt", ascending: true)
        return Array(users)
    }
    
    func getUser(by userName: String) -> User? {
        let query = "userName == [c] %@"
        guard let user = realm.objects(User.self).filter(query, userName).first else {
            return nil
        }
        updateUserCreatedTime(user: user)
        return user
    }
    
    func create(_ user: UserVo) throws {
        do {
            try realm.write {
                // 강제로 에러 발생시키기 위한 코드 (catch 블록의 작동을 확인하기 위한 테스트 목적)
//                throw NSError(domain: "com.example", code: 999, userInfo: nil)
                let user = User(id: user.id,
                                userName: user.userName,
                                avatarUrl: user.avatarUrl,
                                follower: user.follower,
                                following: user.following,
                                bio: user.bio ?? "",
                                createdAt: Date()
                )
                realm.add(user)
            }
        } catch {
            print("유저를 저장하는 데 실패했습니다 - \(error)")
            throw RealmError.failToCreateUser(user: user)
        }
    }

    private func updateUserCreatedTime(user: User) {
        do {
            try realm.write {
                user.createdAt = Date()
            }
        } catch {
            print("유저 정보 업데이트를 실패했습니다 - \(error)")
        }
    }
  
    func delete(_ user: UserVo) {
        do {
            let query = "id == %@"
            let task = realm.objects(User.self).filter(query, user.id)
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("유저를 삭제하는데 실패했습니다 - \(error)")
        }
    }
}

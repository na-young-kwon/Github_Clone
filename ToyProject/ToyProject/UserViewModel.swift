//
//  UserViewModel.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import SwiftUI
import Alamofire

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserResponse?
    @Published var repositories: [UserResponse] = []
    @Published var isLoading = false
    @Published var avatarImage: UIImage?
    
    private var repositoryUseCase = RepositoryUseCase()
    
    func fetchRepositories(forUser username: String) async {
        do {
            repositories = try await repositoryUseCase.getRepositories(forUser: username)
        } catch {
            print("레포지토리를 받아오는 데 실패했습니다. - \(error)")
        }
        isLoading = false // 모든 작업이 끝나면 isLoading 상태를 업데이트합니다.
    }
    
    func fetchUser(forUser username: String) async {
        isLoading = true
        do {
            user = try await repositoryUseCase.getUser(foruser: username)
            // 사용자 정보를 가져온 후 아바타 이미지 로드를 시작합니다.
            if let avatarUrl = user?.avatarUrl {
//                await loadAvatarImage(forUrl: avatarUrl)
            }
        } catch {
            print("유저의 종합정보를 받아오는 데 실패했습니다 - \(error)")
        }
        await fetchRepositories(forUser: username) // 여기서도 비동기 호출을 진행합니다.
    }
    
//    func loadAvatarImage(forUrl avatarUrl: String) async {
//        if let cachedImage = ImageCache.shared.object(forKey: avatarUrl as NSString) {
//            self.avatarImage = cachedImage
//        } else {
//            do {
//                if let downloadedImage = try await repositoryUseCase.networkService.downloadImage(from: avatarUrl) {
//                    ImageCache.shared.setObject(downloadedImage, forKey: avatarUrl as NSString) // 캐시에 이미지 저장
//                    self.avatarImage = downloadedImage
//                }
//            } catch {
//                print("이미지 다운로드 실패: \(error)")
//            }
//        }
//    }
    
    
}


/*
 해당 페이지에 들어간다면,
 1. 캐시메모리에서 해당 이미지가 있는 지 체크한다.
 2. 캐시메모리에서 해당 이미지가 없다면 다운로드한다.
 3. 다운로드한 이미지를 캐시메모리에 저장한다.
 */

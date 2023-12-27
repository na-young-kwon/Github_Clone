//
//  UserNetwork.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import UIKit
import Alamofire

struct Constants {
    static let baseURL = "https://api.github.com/users"
}

class UserNetwork: ObservableObject {
    
    static let shared = UserNetwork()
    
    private init() {}
    
    @Published var user = [User]()
    
    func getUser(id: String) {
//        guard let sessionUrl = URL(string: "\(Constants.baseURL)/id") else {
//            print("유효하지 않은 Url")
//            return
//        }
        
        guard let sessionUrl = URL(string: "\(Constants.baseURL)/\(id)") else {
            print("유효하지 않은 Url")
            return
        }
        
        AF.request(sessionUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let value):
                self.user = value.user
                print(value.user)
            case .failure(let error):
                print("네트워크 요청 실패")
            }
        }
    }
    
    
}

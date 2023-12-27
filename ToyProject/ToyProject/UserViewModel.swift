//
//  UserViewModel.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import Foundation
import Alamofire

//class UserViewModel: ObservableObject {
//    
//    @Published var user = [User]()
//    
//    init() {
//        
//    }
//    
//    func fetchUser() {
//        let url = ""
//        
//    }
//    
//}

/*
 class TodoViewModel: ObservableObject {
     
     @Published var todo = [Todo]()
     
     init() {
         fetchTodos()
     }
     
     func fetchTodos() {
         let url = "https://jsonplaceholder.typicode.com/todos"
         AF.request(url, method: .get)
             .responseDecodable(of: [Todo].self) { data in
                 guard let data = data.value else { return }
                 self.todo = data
             }
     }
     
     func postPost() {
         let url = "https://jsonplaceholder.typicode.com/posts"
     
         let param: [String: Any] = [
             "userId" : 1000,
             "id" : 1000,
             "title" : "title",
             "body" : "body"
         ]
         
         AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
             .responseDecodable(of: Post.self) { response in
                 print("POST DEBUG : \(response)")
             }
     }
 }
 */

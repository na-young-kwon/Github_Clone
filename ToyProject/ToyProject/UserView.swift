//
//  UserView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Spacer(minLength: 10)
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Image(systemName: "person")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.orange)
                        .frame(width: 80, height: 80, alignment: .leading)
                        .cornerRadius(100)
                    Spacer()
                    VStack(alignment: .leading, spacing: 18) {
                        Text("UserName")
                        Text("Bio")
                        HStack {
                            Text("followers 2")
                            Text("following 15")
                        }
                    }
                    Spacer()
                }
                .frame(height: 120)

                // 여기에 타이틀을 추가합니다.
                Text("Repository")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading) // 왼쪽 여백 추가

                List(0 ..< 20) { item in
                    VStack(spacing: 15) {
                        HStack(spacing: 15) {
                            Image(systemName: "book.closed")
                            Text("AUTOMATIC1111/stable-diffusion")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .font(.system(size: 13))
                        
                        HStack(spacing: 15) {
                            Image(systemName: "star")
                                .foregroundColor(.secondary)
                            Text("49,493")
                                .fontWeight(.light)
                            Image(systemName: "circle")
                                .foregroundColor(.secondary)
                            Text("Python")
                                .fontWeight(.light)
                            Image(systemName: "command")
                                .foregroundColor(.secondary)
                            Text("9,208")
                                .fontWeight(.light)
                            Spacer()
                        }
                        .font(.system(size: 12))
                    }
                }
                .listStyle(PlainListStyle())
            }
            // `navigationTitle`을 제거합니다.
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UserView()
}

//struct Repository: Hashable, Identifiable {
//    var id = UUID()
//    var fullname = ""
//    var language = "Swift"
//    var stargazers_count = 0
//    var forkCount = 0
//}
//
//extension Repository {
//    static func dummyData() -> [Repository] {
//        return [
//            Repository(fullname: "Example/Repo1", language: "Swift", stargazers_count: 100, forkCount: 50),
//            Repository(fullname: "Example/Repo2", language: "Objective-C", stargazers_count: 80, forkCount: 30),
//            Repository(fullname: "Example/Repo3", language: "Python", stargazers_count: 150, forkCount: 60),
//        ]
//    }
//}

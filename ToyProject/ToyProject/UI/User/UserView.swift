//
//  UserView.swift
//  ToyProject
//
//  Created by woosub kim on 12/27/23.
//

import SwiftUI
import URLImage

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()
    @Binding var text: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 120, height: 120)
            } else {
                if let user = viewModel.user {
                    Spacer(minLength: 10)
                    HStack {
                        Spacer()
                        if let urlString = user.avatarUrl, let url = URL(string: urlString) {
                            URLImage(url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(100)
                            }
                            
                            .frame(width: 120, height: 120) // 고정된 프레임 크기
                            .cornerRadius(100)
                        } else {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .cornerRadius(100)
                        }
                        
                        Spacer() // 이미지와 텍스트 사이의 공간을 추가
                        VStack(alignment: .leading, spacing: 18) {
                            Text(user.login ?? "n/a")
                            Text(user.bio ?? "n/a")
                            HStack {
                                Text("followers \(user.followers ?? 0)")
                                Text("following \(user.following ?? 0)")
                            }
                        }
                        Spacer()
                    }
                    .frame(height: 150) // 프레임의 높이를 조정하여 더 많은 공간 확보
                    
                    
                    List(viewModel.repositories, id: \.id) { repository in
                        NavigationLink {
                            DetailView(url: repository.htmlUrl ?? "")
                        } label: {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "book")
                                    Text(repository.fullName ?? "")
                                        .fontWeight(.bold)
                                }
                                HStack(spacing: 10) {
                                    Text("⭐️")
                                        .font(.caption)
                                    Text("\(repository.stargazersCount ?? 0)")
                                        .foregroundColor(.secondary)
                                    Text("👀")
                                        .font(.caption)
                                    Text("\(repository.watchersCount ?? 0)")
                                        .foregroundColor(.secondary)
                                    Text("🍴")
                                        .font(.caption)
                                    Text("\(repository.forksCount ?? 0)")
                                        .foregroundColor(.secondary)
                                    Text("Language: \(repository.language ?? "N/A")")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("github ID가 없습니다 🙅🏻‍♂️")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchUser(forUser: text)
                await viewModel.fetchRepositories(forUser: text)
            }
        }
    }
}

#Preview {
    UserView(text: .constant("woobios97"))
}

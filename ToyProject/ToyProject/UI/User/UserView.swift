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
    let text: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 120, height: 120)
            }  else if let errorMessage = viewModel.errorMessage {
                // 오류 메시지가 있을 경우 표시
                Text(errorMessage)
                    .foregroundColor(.primary)
            } else if let user = viewModel.user {
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
                            
                            .frame(width: 120, height: 120)
                            .cornerRadius(100)
                        } else {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .cornerRadius(100)
                        }
                        
                        Spacer()
                        VStack(alignment: .leading, spacing: 18) {
                            Text(user.login ?? "n/a")
                            Text(user.bio ?? "n/a")
                            HStack {
//                                Text("followers \(user.followers ?? 0)")
                                Text("팔로워 \(user.followers ?? 0)")
//                                Text("following \(user.following ?? 0)")
                                Text("팔로잉 \(user.following ?? 0)")
                            }
                        }
                        Spacer()
                    }
                    .frame(height: 150)
                    
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
                                    Text("언어: \(repository.language ?? "N/A")")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        .onAppear {
            Task {
                await viewModel.fetchUser(forUser: text)
            }
        }
    }
}

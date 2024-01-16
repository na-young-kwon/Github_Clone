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
                    if let url = URL(string: user.avatarUrl) {
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
                        Text(user.userName)
                        Text(user.bio ?? "N/A")
                        HStack {
                            Text("follower_n".getLocalizedString(with: user.follower))
                            Text("following_n".getLocalizedString(with: user.following))
                        }
                    }
                    Spacer()
                }
                .frame(height: 150)
                
                List(viewModel.repositories, id: \.id) { repository in
                    NavigationLink {
                        DetailView(url: repository.htmlUrl )
                    } label: {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "book")
                                Text(repository.fullName )
                                    .fontWeight(.bold)
                            }
                            HStack(spacing: 10) {
                                Text("⭐️")
                                    .font(.caption)
                                Text("\(repository.starsCount)")
                                    .foregroundColor(.secondary)
                                Text("👀")
                                    .font(.caption)
                                Text("\(repository.watchersCount)")
                                    .foregroundColor(.secondary)
                                Text("🍴")
                                    .font(.caption)
                                Text("\(repository.forksCount)")
                                    .foregroundColor(.secondary)
                                Text("language_n".getLocalizedString(with: repository.language ?? "N/A"))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            } else {
                Text("no_github_ID".getLocalizedString())
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchUser(forUser: text)
                await viewModel.fetchRepositories(forUser: text)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("저장 실패"), 
                  message: Text("검색어 저장에 실패했습니다."),
                  dismissButton: .default(Text("확인"))
            )
        }
    }
}

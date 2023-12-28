//
//  UserView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI
import URLImage

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()
    @Binding var text: String
    
    var body: some View {
        NavigationView {
            
            VStack {
                if viewModel.isLoading {
                    ProgressView()
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
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(100)
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 18) {
                                Text(user.login ?? "n/a") // 사용자 이름 표시
                                Text(user.bio ?? "n/a")
                                HStack {
                                    Text("followers \(user.followers ?? 0)")
                                    Text("following \(user.following ?? 0)")
                                }
                            }
                            Spacer()
                        }
                        .frame(height: 120)
                        List(viewModel.repositories, id: \.id) { repository in
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
                    } else {
                        Text("github ID가 없습니다 🙅🏻‍♂️")
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchRepositories(forUser: text)
                    await viewModel.fetchUser(forUser: text)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    struct UserView_Previews: PreviewProvider {
        static var previews: some View {
            UserView(text: .constant("woobios97"))
        }
    }
}

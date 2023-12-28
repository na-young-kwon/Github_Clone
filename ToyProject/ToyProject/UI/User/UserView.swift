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
                    Spacer(minLength: 10)
                    HStack {
                        Spacer()
                        if let urlString = viewModel.user?.avatarUrl, let url = URL(string: urlString) {
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
                            Text(viewModel.user?.login ?? "N/A") // 사용자 이름 표시
                            Text(viewModel.user?.bio ?? "N/A")
                            HStack {
                                Text("followers \(viewModel.user?.followers ?? 0)")
                                Text("following \(viewModel.user?.following ?? 0)")
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
}

// Preview 코드
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(text: .constant("woobios97"))
    }
}

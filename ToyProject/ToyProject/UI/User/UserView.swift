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
        ZStack {
            VStack {
               if let errorMessage = viewModel.errorMessage {
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
                }
            }
            .redacted(reason: viewModel.isLoading ? .placeholder : [])
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 120, height: 120)
            }
        }
        .onAppear {
            viewModel.getUser(forUser: text)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("save_user_fail_title".getLocalizedString()),
                  message: Text("save_user_fail_message".getLocalizedString()),
                  dismissButton: .default(Text("ok".getLocalizedString()))
            )
        }
    }
}

//
//  SearchView.swift
//  ToyProject
//
//  Created by woosub kim on 1/12/24.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var isActive = false
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                NavigationLink(isActive: $isActive) {
                    UserView(text: text)
                } label: {
                    EmptyView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("search_ID".getLocalizedString())
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    TextField("search".getLocalizedString(), text: $text) {
                        isActive = true
                    }
                    .frame(height: 40)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("search_history".getLocalizedString())
                        .padding(.horizontal, 16)
                    
                    List {
                        ForEach(viewModel.users, id: \.id) { user in
                            NavigationLink {
                                UserView(text: user.userName)
                            } label: {
                                Text(user.userName)
                            }
                        }
                        .onDelete(perform: viewModel.deleteUserAndRepositories(at:))
                    }
                    .overlay(
                        Group {
                            if viewModel.users.isEmpty {
                                Text("search_history_is_empty".getLocalizedString())
                            }
                        }
                    )
                    .listStyle(.plain)
                }
            }
            .padding(.top, 20)
//            .onTapGesture { hideKeyboard() }
            .onAppear {
                text = ""
                viewModel.fetchUsers()
            }
        }
    }
}

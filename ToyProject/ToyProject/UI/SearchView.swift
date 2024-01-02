//
//  SearchView.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
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
                    UserView(text: $text)
                } label: {
                    EmptyView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("깃헙 ID 검색")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    TextField("search..", text: $text) {
                        isActive = true
                        viewModel.saveSearch(SearchHistory(text: text))
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
                    Text("최근 검색어")
                        .padding(.horizontal, 16)
                    
                    List {
                        ForEach(viewModel.searchHistory, id: \.id) { data in
                            NavigationLink {
                                UserView(text: .constant(data.text))
                            } label: {
                                Text(data.text)
                            }
                        }
                        .onDelete(perform: viewModel.deleteItem(at:))
                    }
                    .overlay(
                        Group {
                            if viewModel.searchHistory.isEmpty {
                                Text("최근 검색 기록이 없습니다.")
                            }
                        }
                    )
                    .listStyle(.plain)
                }
            }
            .padding(.top, 20)
            .onAppear {
                text = ""
                viewModel.fetchSearchHistory()
            }
        }
    }
}

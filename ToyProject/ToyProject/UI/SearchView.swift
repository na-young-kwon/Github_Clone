//
//  SearchView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var isActive = false
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                NavigationLink(isActive: $isActive) {
                    UserView(text: $text)
                } label: {
                    EmptyView()
                }
                
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
                
                Text("최근 검색어")
                List {
                    ForEach(viewModel.searchHistory, id: \.id) { data in
                        NavigationLink {
                            UserView(text: .constant(data.text))
                        } label: {
                            Text(data.text)
                        }
                    }
                    .onDelete(perform: deleteItem)
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
            .padding(.horizontal)
            .padding(.top, 20)
            .onAppear {
                text = ""
                viewModel.fetchSearchHistory()
            }
        }
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        print("\(#fileID) \(#line)-line \(#function)")
          for index in indexSet {
              let searchHistoryItem = viewModel.searchHistory[index]
              viewModel.deleteSearch(searchHistoryItem) // ViewModel의 메소드 호출
          }
          viewModel.searchHistory.remove(atOffsets: indexSet) // 뷰 모델 업데이트
      }
}

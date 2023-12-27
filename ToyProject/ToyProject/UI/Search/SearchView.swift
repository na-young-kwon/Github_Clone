//
//  ContentView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    // 임시 데이터
    private var searchHistory: [SearchHistory] = [SearchHistory(text: "검색어1"), SearchHistory(text: "검색어2")]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("깃헙 ID 검색")
                .font(.headline)
                .padding(.bottom, 10)
            
            TextField("search..", text: $text) {
                print("Return 버튼 눌림")
            }
            .frame(height: 40)
            .padding(.bottom, 20)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
            
            Text("최근 검색어")
            List(searchHistory) { data in
                Text(data.text)
            }
            .listStyle(.plain)
            .overlay(
                Group {
                    if searchHistory.isEmpty {
                        Text("최근 검색 기록이 없습니다.")
                    }
                }
            )
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    SearchView()
}

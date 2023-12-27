//
//  ContentView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("깃헙 ID 검색")
                .font(.headline)
                .padding(.bottom, 10)
            ToolBarTextField(text: $text, placeholder: "search..")
                .frame(height: 40)
                .padding(.bottom, 20)
                
            
            Text("최근 검색어")
            List {
                Text("검색어 1")
                Text("검색어 2")
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    SearchView()
}

//
//  DetailView.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = DetailViewModel()
    @State var text: String = ""
    @State var title: String = ""
    @State var showLoader: Bool = false
    let url: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 10) {
                    TextField("Write Message", text: $text)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        viewModel.searchText(text: text)
                    } label: {
                        Text("검색")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4, style: .circular)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                    }
                }
                
                Text(title)
                    .font(.title)
                    .onReceive(viewModel.$title) { title in
                        self.title = title
                    }
                
                
                if let url = URL(string: url) {
                    WebView(url: url, urlType: .localUrl)
                } else {
                    Text("존재하지 않는 레포지토리 입니다.")
                }
            }
            .padding(16)
            .onReceive(viewModel.$showLoader) { showLoader in
                self.showLoader = showLoader
            }
            if showLoader {
                Loader()
            }
        }
    }
}

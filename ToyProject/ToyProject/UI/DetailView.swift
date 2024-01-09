//
//  DetailView.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import SwiftUI

struct DetailView: View {
    let url: String
    
    var body: some View {
        if let url = URL(string: url) {
            WebView(url: url)
        } else {
            Text("존재하지 않는 레포지토리 입니다.")
        }
    }
}

#Preview {
    DetailView(url: "https://github.com/na-young-kwon/Github_Clone/commits/Feature/Search-User/")
}

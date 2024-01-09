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
            Text("invalid_repository".getLocalizedString())
        }
    }
}

#Preview {
    DetailView(url: "https://github.com/na-young-kwon/Github_Clone/commits/Feature/Search-User/")
}

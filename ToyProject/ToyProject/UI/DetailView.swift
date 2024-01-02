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
        WebView(url: URL(string: url)!)
    }
}

#Preview {
    DetailView(url: "https://github.com/na-young-kwon/Github_Clone/commits/Feature/Search-User/")
}

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
        HStack {
            ToolBarTextField(text: $text, placeholder: "search..")
                .frame(height: 40)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}

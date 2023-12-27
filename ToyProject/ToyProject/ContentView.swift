//
//  ContentView.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "person")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.orange)
                .frame(width: 80, height: 80, alignment: .leading)
                .cornerRadius(100)
            Spacer()
            VStack(alignment: .leading) {
                Text("UserName")
                Spacer()
                Text("Bio")
                Spacer()
                HStack {
                    Text("followers 2")
                    Text("following 15")
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: .infinity, height: 120)
        
        VStack(alignment: .leading) {
            List {
                Section(header: Text("Repostiory")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)) {
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}


struct Repository: Hashable, Identifiable {
    var id = UUID()
    var fullname = ""
    var language = "Swift"
    var stargazers_count = 0
    var forkCount = 0
}

extension Repository {
    static func dummyData() -> [Repository] {
        return [
            Repository(fullname: "Example/Repo1", language: "Swift", stargazers_count: 100, forkCount: 50),
            Repository(fullname: "Example/Repo2", language: "Objective-C", stargazers_count: 80, forkCount: 30),
            Repository(fullname: "Example/Repo3", language: "Python", stargazers_count: 150, forkCount: 60),
        ]
    }
}

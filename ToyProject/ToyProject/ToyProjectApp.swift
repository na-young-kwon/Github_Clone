//
//  ToyProjectApp.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct ToyProjectApp: App {
    
    private let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())
    
    let migrator = Migrator()

    var body: some Scene {
        
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            SearchView()
                .environment(\.urlImageService, urlImageService)
        }
    }
}

//
//  ToyProjectApp.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

@main
struct ToyProjectApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstrainBasedLayoutLogUnsatisfialbe")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            SearchView()
        }
    }
}

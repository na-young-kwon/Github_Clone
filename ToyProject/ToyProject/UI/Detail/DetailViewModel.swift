//
//  DetailViewModel.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/15/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var showLoader: Bool = false
    
    func searchText(text: String) {
        
    }
    
    func setTitle(text: String) {
        title = text
    }
    
    func startLoading() {
        showLoader = true
    }
    
    func stopLoading() {
        showLoader = false
    }
}

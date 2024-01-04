//
//  SearchHistory.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchHistory: Identifiable, Equatable {
    let id: Int
    let text: String
    
    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }
}

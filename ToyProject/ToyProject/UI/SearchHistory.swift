//
//  SearchHistory.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import Foundation

struct SearchHistory: Identifiable, Equatable {
    let id: UUID
    let text: String
    
    init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}

//
//  SearchHistoryForRealm.swift
//  ToyProject
//
//  Created by SNPLAB on 12/28/23.
//

import Foundation
import RealmSwift

class SearchHistoryForRealm: Object {
    @Persisted var text: String
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}

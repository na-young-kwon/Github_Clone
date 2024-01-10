//
//  SearchHistoryForRealm.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/28/23.
//

import Foundation
import RealmSwift

class SearchHistoryForRealm: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var text: String
    
    convenience init(id: UUID, text: String) {
        self.init()
        self.id = id
        self.text = text
    }
}

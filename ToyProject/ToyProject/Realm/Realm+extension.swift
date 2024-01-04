//
//  Realm+extension.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/3/24.
//

import Foundation
import RealmSwift

extension Realm {
    
    static var schemaVersion: UInt64 = 0
    
    static var baseConfiguration: Configuration {
        // 이건 무슨 url 이지
        let supportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
//        print(supportURL)
        
        // 없으면 디렉토리 만들기
        if !FileManager.default.fileExists(atPath: supportURL.absoluteString) {
            try! FileManager.default.createDirectory(at: supportURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        // 경로 존재할때
        return Configuration(
            fileURL: supportURL,
            // encryptionKey 이건 뭐지
            encryptionKey: nil
        )
    }
}

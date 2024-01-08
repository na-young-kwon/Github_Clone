//
//  String+extension.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/5/24.
//

import Foundation

extension String {
    func getLocalizedString() -> String {
        return NSLocalizedString(self, comment: "") // comment는 걍 주석임. ""로 비워둬도 되고, key가 어떤 역할인지 적어두면 가독성 향상
    }
    func getLocalizedString(with argument: CVarArg) -> String {
        return String(format: self.getLocalizedString(), argument)
    }
}

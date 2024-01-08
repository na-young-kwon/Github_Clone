//
//  Localizing.swift
//  ToyProject
//
//  Created by 김우섭 on 1/7/24.
//

import UIKit
import SwiftUI

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}

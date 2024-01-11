//
//  View+extension.swift
//  ToyProject
//
//  Created by nayoung kwon on 1/2/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

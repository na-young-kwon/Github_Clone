//
//  ToolBarTextField.swift
//  ToyProject
//
//  Created by SNPLAB on 12/27/23.
//

import SwiftUI

struct ToolBarTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    
    // view가 생성될 때 최초 한 번 호출됨
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = placeholder
        textField.autocapitalizationType = .none
        textField.delegate = context.coordinator
        textField.leftViewMode = .always
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = padding
        textField.rightView = padding
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .secondarySystemBackground
        textField.clearButtonMode = .whileEditing
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.becomeFirstResponder()
        }
    }
}

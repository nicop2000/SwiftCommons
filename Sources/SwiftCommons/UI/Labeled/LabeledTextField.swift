//
//  LabeledTextField.swift
//  Foodbank
//
//  Created by Nico Petersen on 27.09.23.
//

import Combine
import SwiftUI

public struct LabeledTextField: View {
    @Binding private var text: String
    
    private let label: String
    private var validator: () -> Bool
    private let required: Bool
    
    private let keyboardType: UIKeyboardType
    private let autocapitalization: TextInputAutocapitalization
    private let onEditingChanged: (() -> Void)?
    private let errorText: String?
    private let alignment: Axis.Set
    private let normallyObscured: Bool
    
    public init(text: Binding<String>, label: String, validator: @escaping () -> Bool = { true }, required: Bool = false, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, onEditingChanged: (() -> Void)? = nil, errorText: String? = nil, normallyObscured: Bool = false, alignment: Axis.Set = .horizontal) {
        self._text = text
        self.label = label
        self.validator = validator
        self.required = required
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.onEditingChanged = onEditingChanged
        self.errorText = errorText
        self.normallyObscured = normallyObscured
        self.alignment = alignment
    }
    
    public var body: some View {
        LabeledView(label: label, alignment: self.alignment) {
            CommonTextField(text: $text, validator: validator, required: required, keyboardType: keyboardType, autocapitalization: autocapitalization, onEditingChanged: onEditingChanged, errorText: errorText, normallyObscured: normallyObscured)
        }
    }
}

#Preview {
    LabeledTextField(text: .constant("Text"), label: "Name", alignment: .horizontal)
}

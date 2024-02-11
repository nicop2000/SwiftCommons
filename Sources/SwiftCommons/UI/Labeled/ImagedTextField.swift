//
//  ImagedTextFieldView.swift
//
//
//  Created by Nico Petersen on 31.10.23.
//

import SwiftUI

@available(iOS 17.0, *)
public struct ImagedTextField: View {
    @Binding private var text: String
        
    private let systemName: String
    private var validator: () -> Bool
    private let required: Bool
        
    private let keyboardType: UIKeyboardType
    private let textContentType: UITextContentType?
    private let autocapitalization: TextInputAutocapitalization
    private let onEditingChanged: (Bool) -> Void
    private let errorText: String?
    private let alignment: Axis.Set
    private let normallyObscured: Bool
    private let autoCorrectionDisabled: Bool

    public init(text: Binding<String>, systemName: String, validator: @escaping () -> Bool = { true }, required: Bool = false, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, textContentType: UITextContentType? = nil, onEditingChanged: @escaping ((Bool) -> Void) = { _ in }, errorText: String? = nil, normallyObscured: Bool = false, alignment: Axis.Set = .horizontal, autoCorrectionDisabled: Bool = false) {
        self._text = text
        self.systemName = systemName
        self.validator = validator
        self.required = required
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.textContentType = textContentType
        self.onEditingChanged = onEditingChanged
        self.errorText = errorText
        self.normallyObscured = normallyObscured
        self.alignment = alignment
        self.autoCorrectionDisabled = autoCorrectionDisabled
    }
        
    public var body: some View {
        ImagedView(systemName: systemName, alignment: self.alignment) {
            CommonTextField(text: $text, validator: validator, required: required, keyboardType: keyboardType, autocapitalization: autocapitalization, textContentType: textContentType, onEditingChanged: onEditingChanged, errorText: errorText, normallyObscured: normallyObscured, autoCorrectionDisabled: autoCorrectionDisabled)
        }
    }
}

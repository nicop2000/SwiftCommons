//
//  LabeledTextField.swift
//  Foodbank
//
//  Created by Nico Petersen on 25.09.23.
//

import SwiftUI

@available(iOS 17.0, *)
public struct CommonTextField: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var validator: () -> Bool
    var required: Bool

    private let keyboardType: UIKeyboardType
    private let textContentType: UITextContentType?
    private let autocapitalization: TextInputAutocapitalization
    private let onEditingChanged: (Bool) -> Void
    private let errorText: String?
    private let normallyObscured: Bool
    private let placeholder: String
    private let autoCorrectionDisabled: Bool

    @State private var clearButton = false
    @State private var obscureDisabled: Bool = false

    public init(text: Binding<String>, validator: @escaping () -> Bool = { true }, required: Bool = false, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, textContentType: UITextContentType? = nil, onEditingChanged: @escaping ((Bool) -> Void) = {_ in}, errorText: String? = nil, normallyObscured: Bool = false, placeholder: String = "", autoCorrectionDisabled: Bool = false) {
        self._text = text
        self.validator = validator
        self.required = required
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.onEditingChanged = onEditingChanged
        self.errorText = errorText
        self.normallyObscured = normallyObscured
        self.placeholder = placeholder
        self.autoCorrectionDisabled = autoCorrectionDisabled
    }

    public var body: some View {
        HStack {
            if isEnabled {
                Section {
                    if obscureDisabled || !normallyObscured {
                        TextField(required ? "erforderlich" : placeholder, text: $text,
                                  onEditingChanged: onEditingChanged)
                                  .keyboardType(keyboardType)
                                  .textContentType(textContentType)
                                  .textInputAutocapitalization(autocapitalization)
                                  .autocorrectionDisabled(autoCorrectionDisabled)
                                  .onAppear {
                                      clearButton = !text.isEmpty
                                  }
                                  .focused($isFocused)
                                  .onChange(of: text) { newValue in
                                      clearButton = !newValue.isEmpty
                                  }
                    } else {
                        SecureField(required ? "erforderlich" : "", text: $text)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(.never)
                            .textContentType(textContentType)
                            .autocorrectionDisabled()
                            .onAppear {
                                clearButton = !text.isEmpty
                            }
                            .focused($isFocused)
                            .onChange(of: text) { newValue in
                                clearButton = !newValue.isEmpty
                                onEditingChanged(false)
                            }
                            .onChange(of: isFocused) {
                                obscureDisabled = false
                            }
                    }
                    if clearButton && isFocused {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                        }.buttonStyle(.borderless)
                    }
                    if normallyObscured && !text.isEmpty {
                        Button(action: {
                            obscureDisabled.toggle()
                        }, label: {
                            Image(systemName: obscureDisabled ? "eye" : "eye.slash").foregroundStyle(.gray)
                        })
                        .padding(.trailing, 5)
                    }
                }
            } else {
                Text(text)
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: "lock.fill")
                    .foregroundColor(.secondary)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack {
        LabeledTextField(text: .constant("email@google.com"),
                         label: "E-Mail", required: true, alignment: .horizontal)

        LabeledTextField(text: .constant("password123"),
                         label: "Passwort", required: true, normallyObscured: true, alignment: .vertical)
    }
}

//
//  LabeledTextField.swift
//  Foodbank
//
//  Created by Nico Petersen on 25.09.23.
//

import SwiftUI

public struct CommonTextField: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var text: String

    var validator: () -> Bool
    var required: Bool

    private let keyboardType: UIKeyboardType
    private let autocapitalization: TextInputAutocapitalization
    private let onEditingChanged: (() -> Void)?
    private let errorText: String?
    private let normallyObscured: Bool

    @State private var clearButton = false
    @State private var obscureDisabled: Bool = false

    public init(text: Binding<String>, validator: @escaping () -> Bool = { true }, required: Bool = false, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .sentences, onEditingChanged: (() -> Void)? = nil, errorText: String? = nil, normallyObscured: Bool = false) {
        self._text = text
        self.validator = validator
        self.required = required
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.onEditingChanged = onEditingChanged
        self.errorText = errorText
        self.normallyObscured = normallyObscured
    }

    public var body: some View {
        HStack {
            if isEnabled {
                Section {
                    if obscureDisabled || !normallyObscured {
                        TextField(required ? "erforderlich" : "", text: $text)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(autocapitalization)
                            .onAppear {
                                clearButton = !text.isEmpty
                            }
                            .onChange(of: text) { newValue in
                                clearButton = !newValue.isEmpty
                                if onEditingChanged != nil {
                                    onEditingChanged!()
                                }
                            }
                    } else {
                        SecureField(required ? "erforderlich" : "", text: $text)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(.never)
                            .onAppear {
                                clearButton = !text.isEmpty
                            }
                            .onChange(of: text) { newValue in
                                clearButton = !newValue.isEmpty
                                if onEditingChanged != nil {
                                    onEditingChanged!()
                                }
                            }
                    }
                    if clearButton {
                        if normallyObscured {
                            if obscureDisabled {
                                Button(action: {
                                    obscureDisabled = false
                                }, label: {
                                    Image(systemName: "eye").foregroundStyle(.gray)
                                })
                            } else {
                                Button(action: {
                                    obscureDisabled = true
                                }, label: {
                                    Image(systemName: "eye.slash").foregroundStyle(.gray)
                                })
                            }
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                            }.buttonStyle(.borderless)
                        }
                    }

                } footer: {
                    if let errorText {
                        if validator() && !errorText.isEmpty {
                            HStack {
                                Text(errorText)
                                    .foregroundStyle(.red)
                                    .font(.caption)
                            }
                            Spacer()
                        }
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

#Preview {
    VStack {
        LabeledTextField(text: .constant("email@google.com"),
                         label: "E-Mail", required: true, alignment: .horizontal)

        LabeledTextField(text: .constant("password123"),
                         label: "Passwort", required: true, normallyObscured: true, alignment: .vertical)
    }
}

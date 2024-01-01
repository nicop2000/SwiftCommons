//
//  CommonTextEditor.swift
//
//
//  Created by Nico Petersen on 15.10.23.
//

import SwiftUI

public struct CommonTextEditor: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var text: String
    @FocusState private var isFocused: Bool
    private let autocapitalization: TextInputAutocapitalization
    private let onEditingChanged: (() -> Void)?
    @State private var clearButton = false
    private let placeholder: String

    public init(text: Binding<String>, placeholder: String = "", autocapitalization: TextInputAutocapitalization = .sentences, onEditingChanged: (() -> Void)? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.autocapitalization = autocapitalization
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        HStack {
            if isEnabled {
                Section {
                    TextEditor(text: isFocused ? $text : text.isEmpty ? .constant(placeholder) : $text)
                        .focused($isFocused)
                        .onChange(of: isFocused) { isFocused in
                            if !isFocused {
                                if text.isEmpty {
                                    text = placeholder
                                }
                            }
                        }
                        .padding(0)
                        .textInputAutocapitalization(autocapitalization)
                        .foregroundColor(self.text == placeholder || self.text.isEmpty && !isFocused ? .gray : .primary)
                        .onTapGesture {
                            if self.text == placeholder {
                                self.text = ""
                            }
                        }
                        .onAppear {
                            clearButton = !text.isEmpty
                        }

                        .onChange(of: text) { newValue in
                            clearButton = !newValue.isEmpty
                            if onEditingChanged != nil {
                                onEditingChanged!()
                            }
                        }

                    if clearButton && isFocused {
                        Button(action: {
                            if !isFocused {
                                text = placeholder
                            } else {
                                self.text = ""
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                        }.buttonStyle(.borderless)
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

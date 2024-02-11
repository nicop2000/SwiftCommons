//
//  LabeledTextField.swift
//  Foodbank
//
//  Created by Nico Petersen on 27.09.23.
//

import SwiftUI

@available(iOS 17.0, *)
public struct LabeledTextField<Content: View>: View {
    @Binding private var text: String

    private let label: String
    private var validator: () -> Bool
    private let required: Bool

    private let keyboardType: UIKeyboardType
    private let autocapitalization: TextInputAutocapitalization
    private let textContentType: UITextContentType?
    private let onEditingChangedStart: (() -> Void)?
    private let onEditingChangedEnd: (() -> Void)?
    private let errorText: String?
    private let alignment: Axis.Set
    private let normallyObscured: Bool
    private let labelColor: Color
    private let overlay: () -> Content
    private let errorColor: Color
    private let validPadding: CGFloat
    private let innerPadding: CGFloat
    private let autoCorrectionDisabled: Bool

    @FocusState var isFocused: Bool

    @State var isValid = true

    public init(text: Binding<String>, label: String, validator: @escaping () -> Bool = { true }, required: Bool = false, keyboardType: UIKeyboardType = .default, autocapitalization: TextInputAutocapitalization = .never, textContentType: UITextContentType? = nil, onEditingChangedStart: (() -> Void)? = nil, onEditingChangedEnd: (() -> Void)? = nil, errorText: String? = nil, normallyObscured: Bool = false, alignment: Axis.Set = .horizontal, labelColor: Color = .primary, @ViewBuilder overlay: @escaping () -> Content = { EmptyView() }, errorColor: Color = .red, innerPadding: CGFloat = 0, validPadding: CGFloat = 0, autoCorrectionDisabled: Bool = false) {
        self._text = text
        self.label = label
        self.validator = validator
        self.required = required
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.textContentType = textContentType
        self.onEditingChangedStart = onEditingChangedStart
        self.onEditingChangedEnd = onEditingChangedEnd
        self.errorText = errorText
        self.normallyObscured = normallyObscured
        self.alignment = alignment
        self.labelColor = labelColor
        self.overlay = overlay
        self.errorColor = errorColor
        self.validPadding = validPadding
        self.innerPadding = innerPadding
        self.autoCorrectionDisabled = autoCorrectionDisabled
    }

    public var body: some View {
        VStack {
            LabeledView(label: label, alignment: self.alignment, labelColor: labelColor) {
                CommonTextField(text: $text, validator: {
                    isValid
                }, required: required, keyboardType: keyboardType, autocapitalization: autocapitalization, textContentType: textContentType,
                    onEditingChanged: { status in
                    if status {
                        if let onEditingChangedStart {
                            onEditingChangedStart()
                        }
                    } else {
                        self.isValid = validator()
                        if let onEditingChangedEnd {
                            onEditingChangedEnd()
                        }
                    }
                }, errorText: errorText, normallyObscured: normallyObscured, autoCorrectionDisabled: autoCorrectionDisabled)
                .onChange(of: text) {
                    if !self.isValid {
                        self.isValid = validator()
                    }
                }
            }
            .padding(innerPadding)
            .overlay {
                overlay()
            }
            if let errorText, !errorText.isEmpty {
                if !self.isValid {
                    HStack(alignment: .center) {
                        Text(errorText)
                            .foregroundStyle(errorColor)
                            .font(.caption)
                            .lineLimit(3)
                    }
                    .padding(.bottom, 5)
                }
            }
        }
        .padding(.bottom, self.isValid ? validPadding : 0)
    }
}

@available(iOS 17.0, *)
#Preview {
    LabeledTextField(text: .constant("Text"), label: "Name", alignment: .horizontal)
}

//
//  LabeledView.swift
//  Foodbank
//
//  Created by Nico Petersen on 27.09.23.
//

import SwiftUI

struct LabeledView<Content: View>: View {
    var label: String?
    var content: Content
    var alignment: Axis.Set
    var labelColor: Color
    var horizontalPadding: CGFloat
    
    public init(label: String? = nil, alignment: Axis.Set = .horizontal, labelColor: Color = .primary, horizontalPadding: CGFloat = 150, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
        self.alignment = alignment
        self.labelColor = labelColor
        self.horizontalPadding = horizontalPadding
    }

    var body: some View {
        VStack {
            Group {
                if alignment == .horizontal {
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            if let label {
                                Text(label)
                                    .foregroundColor(labelColor)
                                    .frame(width: horizontalPadding, alignment: .leading)
                            }
                            content
                        }
                    }
                }
                else {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {
                            if let label {
                                Text(label)
                                    .foregroundColor(labelColor)
                            }
                            content
                        }
                    }
                }
            }

        }
    }
}

#Preview {
    LabeledView(label: "Label", alignment: .horizontal, labelColor: .red) {
        Text("Text")
    }
}

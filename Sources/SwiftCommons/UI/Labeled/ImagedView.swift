//
//  ImagedView.swift
//
//
//  Created by Nico Petersen on 31.10.23.
//

import SwiftUI

public struct ImagedView<Content: View>: View {
    var systemName: String
    var content: Content
    var alignment: Axis.Set
    var labelColor: Color
    var horizontalPadding: CGFloat
    var renderingMode: SymbolRenderingMode
    
    public init(systemName: String, renderingMode: SymbolRenderingMode = .multicolor, alignment: Axis.Set = .horizontal, labelColor: Color = .primary, horizontalPadding: CGFloat = 25, @ViewBuilder content: () -> Content) {
        self.systemName = systemName
        self.content = content()
        self.alignment = alignment
        self.labelColor = labelColor
        self.horizontalPadding = horizontalPadding
        self.renderingMode = renderingMode
    }

    public var body: some View {
        VStack {
            Group {
                if alignment == .horizontal {
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            
                                Image(systemName: systemName)
                                    .symbolRenderingMode(renderingMode)
                                    .frame(minWidth: horizontalPadding, alignment: .leading)
                            
                            content
                        }
                    }
                }
                else {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {
                            
                                Image(systemName: systemName)
                                    .symbolRenderingMode(renderingMode)
                            
                            content
                        }
                    }
                }
            }

        }
    }
}

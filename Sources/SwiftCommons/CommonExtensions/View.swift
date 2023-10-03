//
//  View.swift
//
//
//  Created by Nico Petersen on 10.09.23.
//

import SwiftUI

public extension View {
    static func + <T>(lhs: Self, rhs: T) -> some View where T: View {
        HStack {
            lhs
            rhs
        }
    }

    func visible(_ visible: Binding<Bool>) -> some View {
        modifier(VisibilityModifier(visible))
    }

    func visible(_ visibles: Binding<Bool>...) -> some View {
        modifier(VisibilityModifierVariadic(visibles))
    }

    func delayedVisible(_ visible: Binding<Bool>, delay: TimeInterval) -> some View {
        modifier(DelayedVisibilityModifier(visible: visible, delay: delay))
    }
    
    func deletable(action: @escaping () -> Void) -> some View {
        
        swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button("Delete") {
                action()
            }.tint(.red)
        }
    }
}

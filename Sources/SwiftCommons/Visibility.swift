//
//  SwiftUIView.swift
//
//
//  Created by Nico Petersen on 16.09.23.
//

import SwiftUI

struct VisibilityModifier: ViewModifier {
    @Binding var visible: Bool
    
    init(_ visible: Binding<Bool>) {
        self._visible = visible
    }

    func body(content: Content) -> some View {
        if visible {
            content
        }
    }
}

struct VisibilityModifierVariadic: ViewModifier {
    var visible: [Binding<Bool>]

    init(_ visible: [Binding<Bool>]) {
        self.visible = visible
    }

    func body(content: Content) -> some View {
        if visible.filter({ !$0.wrappedValue }).isEmpty {
            content
        }
    }
}

struct DelayedVisibilityModifier: ViewModifier {
    @Binding var visible: Bool
    private var delay: TimeInterval
    @State var timer: Timer?
    @State private var timedOut: Bool = false

    init(visible: Binding<Bool>, delay: TimeInterval) {
        self._visible = visible
        self.delay = delay
    }

    func body(content: Content) -> some View {
        Group {
            content
                .visible($visible, $timedOut)

        }.onChange(of: $visible.wrappedValue) { vis in
            if vis {
                timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { _ in
                    timerExpired()
                })
            } else {
                invalidateTimer()
            }
        }
    }

    func timerExpired() {
        timedOut = true
    }

    func invalidateTimer() {
        timedOut = false
        timer?.invalidate()
        timer = nil
    }
}

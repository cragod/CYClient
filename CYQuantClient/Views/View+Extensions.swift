//
//  View+Extensions.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/19.
//

import SwiftUI

extension View {
    
    func setupRefresh(_ block: @escaping ()->()) -> some View {
        self.toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { block() }) {
                    Image(systemName: "arrow.clockwise")
                }
                .keyboardShortcut("r", modifiers: .command)
            }
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                }) {
                    Image(systemName: "sidebar.left")
                }
                .keyboardShortcut("s", modifiers: .command)
            }
        }
    }
    
}

//
//  CYQuantClientApp.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import SwiftUI

@main
struct CYQuantClientApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SideBar()
            }
            .navigationTitle("CY.Quant")        }
    }
}

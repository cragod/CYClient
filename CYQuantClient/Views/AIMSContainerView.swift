//
//  AIMSContainerView.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/18.
//

import SwiftUI

struct AIMSContainerView: View {
    var tabView: some View {
        TabView {
            ViewHolder.shared.view(for: "pos", defaultView: AnyView(AIMSPositionListView()))
                .tabItem({
                    Text("当前仓位")
                })
                .font(.title)
                .tag(1)
            ViewHolder.shared.view(for: "sellings", defaultView: AnyView(AIMSSellingListView()))
                .tabItem { Text("平仓记录") }
                .font(.title)
                .tag(2)
            Text("zzzzzz")
                .tabItem { Text("乘客信息") }
                .font(.title)
                .tag(3)
        }
    }
    var body: some View {
        #if os(macOS)
        return tabView
            .padding()
            .padding(.top, -10)
        #else
        return tabView
        #endif
    }
}

//
//  AIMSContainerView.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/18.
//

import SwiftUI

enum AIMSSubViewKey: String {
    case position
    case sellings
    case holders
}

struct AIMSContainerView: View {
    @State private var selectedTab = 0
    private var positionListViewModel = AIMSPositionListViewModel()
    private var sellingsListViewModel = AIMSSellingListViewModel()
    
    var tabView: some View {
        TabView(selection: $selectedTab) {
            ViewHolder.shared.view(for: AIMSSubViewKey.position.rawValue, defaultView: AnyView(AIMSPositionListView(listViewModel: positionListViewModel)))
                .tabItem({
                    Text("当前仓位")
                })
                .font(.title)
                .tag(0)
            ViewHolder.shared.view(for: AIMSSubViewKey.sellings.rawValue, defaultView: AnyView(AIMSSellingListView(listViewModel: sellingsListViewModel)))
                .tabItem { Text("平仓记录") }
                .font(.title)
                .tag(1)
            Text("zzzzzz")
                .tabItem { Text("乘客信息") }
                .font(.title)
                .tag(2)
        }
        .setupRefresh {
            print(selectedTab)
            switch selectedTab {
            case 0:
                positionListViewModel.load()
            case 1:
                sellingsListViewModel.load()
            default: break
            }
        }
    }
    var body: some View {
        tabView
            .padding()
            .padding(.top, -10)
    }
}

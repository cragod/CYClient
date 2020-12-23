//
//  BacktestOverviewDetailView.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import SwiftUI

struct BacktestOverviewDetailView: View {
    @ObservedObject var viewModel: BacktestTaskDetailViewModel
    
    var body: some View {
        content
            .frame(minWidth: 700)
            .onAppear(perform: {
                if viewModel.items.isEmpty {
                    viewModel.loadItems()
                }
            })
    }
    
    @ViewBuilder
    var content: some View {
        if viewModel.loading {
            ProgressView()
        } else {
            scrollView
        }
    }
    
    @ViewBuilder
    var scrollView: some View {
        let gridItemLayout = [GridItem(.flexible(maximum: 100)),
                              GridItem(.flexible(maximum: 80)),
                              GridItem(.flexible()),
                              GridItem(.flexible(maximum: 120)),
                              GridItem(.flexible(maximum: 150))]
        
        ScrollView {
            LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 5, pinnedViews: [.sectionHeaders, .sectionFooters], content: {
                Section(header: VStack {
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10, content: {
                        Text("策略名")
                        Text("TimeFrame")
                        Text("参数组")
                        Text("累积净值")
                        Text("日期区间")
                    })
                    .font(.title3)
                    Divider()
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                }.background(Color("MainBackground"))
                ) {
                    ForEach(viewModel.items, id: \.paramIdentifier) { item in
                        Text(item.strategyName ?? "\\")
                        Text(item.strategyTimeFrame ?? "\\")
                        Text(item.strategyParams ?? "\\")
                        Text("\(item.equityCurve)")
                        Text(item.strategyDuration ?? "\\")
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                }
            })
            .font(.body)
        }
        .padding()
        .frame(minWidth: 800, minHeight: 400)
    }
}

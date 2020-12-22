//
//  AIMSPositionListView.swift
//  GatroQuant
//
//  Created by HYL on 2020/12/19.
//

import SwiftUI

struct AIMSPositionListView: View {
    @ObservedObject var listViewModel = AIMSPositionListViewModel()
    
    @ViewBuilder
    var body: some View {
        content
            .setupRefresh {
                listViewModel.load()
            }
    }
    
    @ViewBuilder
    var footer: some View {
        let hasItems = !listViewModel.items.isEmpty
        let hasBalance = !listViewModel.balanceInfo.isEmpty
        if hasItems || hasBalance {
            VStack(alignment: .leading, spacing: 10) {
                Divider()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                if hasItems {
                    HStack {
                        Text("总仓位:")
                        Text("\(NumberValueFormatter.formattedFloat(listViewModel.totalCost)) USDT")
                    }
                }
                if hasBalance {
                    ForEach(Array(listViewModel.balanceInfo.keys), id: \.self) { key in
                        HStack {
                            Text("\(key) 余额:")
                            Text("\(NumberValueFormatter.formattedFloat(listViewModel.balanceInfo[key]!)) USDT")
                        }
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
    
    @ViewBuilder
    var content: some View {
        if listViewModel.items.isEmpty || listViewModel.loading {
            ProgressView()
                .onAppear(perform: {
                    listViewModel.load()
                })
        } else if let errorMsg = listViewModel.error?.description {
            Text(errorMsg)
        } else {
            let gridItemLayout = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
            
            ScrollView {
                LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10, content: {
                    Section(header: VStack {
                        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10, content: {
                            Text("币对")
                            Text("交易所")
                            Text("成本")
                            Text("持仓")
                            Text("均价")
                            Text("当前价")
                            Text("浮盈")
                            Text("最后买入")
                        })
                        .font(.title3)
                        Divider()
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    }, footer: footer
                    ) {
                        ForEach(listViewModel.items, id: \.id) { item in
                            Text(item.coinPair)
                            Text("\(item.exchange)")
                            Text(NumberValueFormatter.formattedFloat(item.cost))
                            Text(NumberValueFormatter.formattedFloat(item.hold))
                            Text(NumberValueFormatter.formattedFloat(item.averageCost))
                            Text(NumberValueFormatter.formattedFloat(item.currentPrice))
                            Text(item.hold.isZero ? "/" : NumberValueFormatter.formattedPercent(item.profit))
                            Text(DateValueFormatter.formatDate(DateValueFormatter.analyseISO8601(item.updateAt)!))
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
}

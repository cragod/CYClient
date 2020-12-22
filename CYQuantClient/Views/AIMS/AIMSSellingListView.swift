//
//  AIMSSellingListView.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/19.
//

import SwiftUI

struct AIMSSellingListView: View {
    
    @ObservedObject var listViewModel = AIMSSellingListViewModel()
    
    @ViewBuilder
    var footer: some View {
        VStack( alignment: .center, spacing: 10, content: {
            Divider()
            HStack {
                Text("期间总收益:")
                Text("\(NumberValueFormatter.formattedFloat(listViewModel.totalProfit)) USDT")
            }
            .padding(.leading, 10)
        })
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
                                  GridItem(.flexible())]
            
            ScrollView {
                LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10, pinnedViews: [.sectionHeaders, .sectionFooters], content: {
                    Section(header: VStack {
                        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 10, content: {
                            Text("币对")
                            Text("交易所")
                            Text("成本")
                            Text("数量")
                            Text("平仓价")
                            Text("盈利")
                            Text("日期")
                        })
                        .font(.title3)
                        Divider()
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    }
                    .background(Color("SubBackground"))
                    , footer: footer
                        .background(Color("SubBackground"))
                    ) {
                        ForEach(listViewModel.items, id: \.id) { item in
                            Text(item.coinPair)
                            Text("\(item.exchange)")
                            Text(NumberValueFormatter.formattedFloat(item.cost))
                            Text(NumberValueFormatter.formattedFloat(item.hold))
                            Text(NumberValueFormatter.formattedFloat(item.closePrice))
                            Text(NumberValueFormatter.formattedPercent(item.profitPercent) + "(\(NumberValueFormatter.formattedFloat(item.profit)))")
                            Text(DateValueFormatter.formatDate(DateValueFormatter.analyseISO8601(item.date)!))
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
    
    @ViewBuilder
    var body: some View {
        content
    }
}

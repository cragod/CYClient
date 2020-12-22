//
//  BacktestContainerView.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import SwiftUI

struct BacktestContainerView: View {
    private let backtestViewModel = BacktestTaskListViewModel()
    
    var body: some View {
        content
            .setupRefresh {
                // TODO
            }
            .onAppear(perform: {
                if backtestViewModel.tasks.isEmpty {
                    backtestViewModel.loadTasks()
                }
            })
    }
    
    @ViewBuilder
    var content: some View {
        VStack{
            Divider().padding(.bottom, 0)
            NavigationView {
                BacktestOverviewListView(viewModel: backtestViewModel)
                Text("左边选个任务查看")
            }
        }
    }
}

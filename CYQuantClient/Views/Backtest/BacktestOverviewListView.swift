//
//  BacktestOverviewListView.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import SwiftUI

struct BacktestOverviewListView: View {
    @ObservedObject var viewModel: BacktestTaskListViewModel

    var body: some View {
        content.onAppear(perform: {
            viewModel.loadTasks()
        })
    }
    
    @ViewBuilder
    var content: some View {
        if viewModel.loadingTasks {
            ProgressView()
        } else {
            List(viewModel.tasks, id: \.name) { task in
                NavigationLink(
                    destination: BacktestOverviewDetailView(viewModel: BacktestTaskDetailViewModel(name: task.name))) {
                    VStack {
                        HStack {
                            Text(task.name).font(.title3)
                            Spacer()
                            Text("数量:\(task.count)").font(.body).padding(.trailing, 10)
                        }.padding(.top, 10)
                        Divider().padding([.top, .bottom], 0)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

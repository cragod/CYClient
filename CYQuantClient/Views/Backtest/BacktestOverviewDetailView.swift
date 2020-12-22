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
        Text(viewModel.name)
    }
}
